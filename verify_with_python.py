"""
Independent check of the GAMS model (supply_chain_network_design.gms) using SciPy's HiGHS MILP solver.

It parses the data straight from supply_chain_network_design.gms, rebuilds the same MILP and prints the
optimal objective value, so the GAMS result can be reproduced without a GAMS licence.

Usage:  python verify_with_python.py [path/to/supply_chain_network_design.gms] [min_wh max_wh]
Needs:  numpy, scipy >= 1.9
"""
import re
import sys
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds
from scipy.sparse import lil_matrix

path = sys.argv[1] if len(sys.argv) > 1 else "supply_chain_network_design.gms"
wh_min, wh_max = (int(sys.argv[2]), int(sys.argv[3])) if len(sys.argv) > 3 else (5, 7)
txt = open(path, encoding="utf-8").read().replace("\r", "")

names = [s.strip() for s in re.search(r"i\s*/(.*?)/", txt, re.S).group(1).split(",")]
n = len(names)
sizes = ["Small", "Medium", "Large"]


def vec(label):
    body = re.search(label + r"\(\w\)\s*/(.*?)/", txt, re.S).group(1)
    d = dict(re.findall(r"([A-Za-z]+)\s+([\d.]+)", body))
    return np.array([float(d[k]) for k in names])


def table(label):
    body = re.search(r"Table\s+" + label + r"\(\w,\w\)(.*?);", txt, re.S).group(1).strip().splitlines()
    rows = {}
    for line in body[1:]:
        p = line.split()
        if p:
            rows[p[0]] = [float(v) for v in p[1:]]
    return np.array([rows[k] for k in names])


d, Pcap, pVar, WhVar, FacFix = (vec(v) for v in ("d", "Pcap", "pVar", "WhVar", "FacFix"))
a, transWC, WhFix, Whcap = (table(t) for t in ("a", "transWC", "WhFix", "Whcap"))

# variable layout: H[l,i] (n*n) | x[i,j] (n*n) | y[i,w] (n*3) | r[l] (n)
nH, nx, ny = n * n, n * n, n * 3
oH, ox, oy, orr = 0, nH, nH + nx, nH + nx + ny
N = nH + nx + ny + n
H = lambda l, i: oH + l * n + i
X = lambda i, j: ox + i * n + j
Y = lambda i, w: oy + i * 3 + w
R = lambda l: orr + l

c = np.zeros(N)
for l in range(n):
    for i in range(n):
        c[H(l, i)] = a[l, i] + pVar[l]
for i in range(n):
    for j in range(n):
        c[X(i, j)] = d[j] * (transWC[i, j] + WhVar[i])
    for w in range(3):
        c[Y(i, w)] = WhFix[i, w]
for l in range(n):
    c[R(l)] = FacFix[l]

rows, lo, hi = [], [], []
A = lil_matrix((3 * n + n * n + 2 * n + 4, N))
k = 0


def add(coefs, lb, ub):
    global k
    for idx, v in coefs:
        A[k, idx] = v
    lo.append(lb); hi.append(ub); k += 1


for j in range(n):                                   # each customer served by exactly one warehouse
    add([(X(i, j), 1) for i in range(n)], 1, 1)
add([(R(l), 1) for l in range(n)], 4, 5)             # 4-5 facilities
add([(Y(i, w), 1) for i in range(n) for w in range(3)], wh_min, wh_max)  # warehouses
for i in range(n):
    add([(Y(i, w), 1) for w in range(3)], 0, 1)      # at most one size per site
    add([(X(i, j), d[j]) for j in range(n)] + [(Y(i, w), -Whcap[i, w]) for w in range(3)], -np.inf, 0)  # warehouse capacity
    add([(H(l, i), 1) for l in range(n)] + [(X(i, j), -d[j]) for j in range(n)], 0, 0)                    # flow balance
for l in range(n):
    add([(H(l, i), 1) for i in range(n)] + [(R(l), -Pcap[l])], -np.inf, 0)   # facility capacity
for i in range(n):
    for j in range(n):
        add([(X(i, j), 1)] + [(Y(i, w), -1) for w in range(3)], -np.inf, 0)  # only open warehouses serve

integrality = np.r_[np.zeros(nH), np.ones(N - nH)]
ub = np.r_[np.full(nH, np.inf), np.ones(N - nH)]
res = milp(c, constraints=LinearConstraint(A.tocsr()[:k], lo, hi), integrality=integrality,
           bounds=Bounds(np.zeros(N), ub), options={"mip_rel_gap": 1e-9})

print("status:", res.message)
print(f"optimal total cost: {res.fun:,.0f}")
r = np.round(res.x[orr:])
print("facilities:", [names[l] for l in range(n) if r[l] > 0.5])
print("warehouses:", [(names[i], sizes[w]) for i in range(n) for w in range(3) if res.x[Y(i, w)] > 0.5])
