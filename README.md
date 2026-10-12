# Supply Chain Network Design: Three-Echelon Facility–Warehouse Location (GAMS)

> A mixed-integer optimization model that decides **which plants to open, which warehouses to open (and in what size), and which warehouse serves each customer zone** at minimum total cost.

![GAMS](https://img.shields.io/badge/GAMS-MIP-blue)
![Python](https://img.shields.io/badge/Python-verification-3776AB)
![License](https://img.shields.io/badge/License-MIT-green)

Bachelor's thesis project, Industrial Engineering, Yıldız Technical University (2025).
Author: **Nijat Aliyev**

---

## What this project does

Where plants and warehouses are placed determines a large part of a supply chain's long-term cost. This project builds a **capacitated three-echelon network design model** (plants → warehouses → customer zones) and solves it as a MILP in GAMS.

The model is applied to a case with **13 candidate locations across Azerbaijan**. Every location can host a plant, a warehouse (Small, Medium or Large), and a customer demand zone. The company that supplied the case data is not named, and all figures here come from my own model runs.


*Optimal network of the base case (schematic, approximate coordinates, no base map). Red: plant → warehouse. Green: warehouse → customer.*

## Key results

| | |
|---|---|
| **Optimal total cost (base case)** | **19,252,800** |
| Plants opened (5) | Baku, Khankandi, Qubadli, Lachin, Ganja |
| Warehouses opened (7) | Baku (Large), Lachin (Large), Khankandi (Medium), Qubadli (Medium), Nakhchivan (Medium), Ganja (Medium), Shamakhi (Small) |
| Total demand served | 1,091,000 units |
| Share of fixed costs | ≈ 0.5% of total cost (96,550); transport and handling dominate |

### Scenario analysis: number of warehouses

| Warehouses opened | Fixed cost | Total cost | Change vs. previous |
|:-:|--:|--:|--:|
| 4 | 90,950 | 26,530,550 | n/a |
| 5 | 93,750 | 19,803,250 | −25.4% |
| 6 | 96,750 | 19,434,500 | −1.9% |
| **7 (base case)** | 96,550 | **19,252,800** | −0.9% |
| 10 | 93,300 | 19,126,050 | −0.7% |

Going from 4 to 5 warehouses cuts cost sharply. Beyond 7 the returns diminish: 10 warehouses is only about 0.66% cheaper than 7.

## Model

**Sets:** `l` plants · `i` warehouse sites · `j` customer zones · `w` warehouse sizes (Small, Medium, Large)

| Variable | Type | Meaning |
|---|---|---|
| `r(l)` | binary | 1 if plant *l* is opened |
| `y(i,w)` | binary | 1 if a warehouse of size *w* is opened at site *i* |
| `x(i,j)` | binary | 1 if customer zone *j* is served by warehouse *i* (single sourcing) |
| `H(l,i)` | continuous ≥ 0 | units shipped from plant *l* to warehouse *i* |

**Objective:** minimize plant fixed cost + warehouse fixed cost (by size) + production cost + plant→warehouse transport + warehouse handling + warehouse→customer transport.

**Main constraints**

- each customer zone is assigned to exactly one warehouse
- 4–5 plants open; 5–7 warehouses open (bounds are changed per scenario)
- at most one warehouse size per site
- warehouse capacity ≥ demand assigned to it
- flow balance: inbound flow to a warehouse = demand it serves
- plant output ≤ plant capacity × open indicator
- customers can only be served from open warehouses

## Repository structure

```
.
├── model/
│   ├── supply_chain_network_design.gms   # GAMS model (data + model + solve + export)
│   ├── verify_with_python.py             # independent re-solve with SciPy/HiGHS + network figure
│   └── requirements.txt
├── data/
│   └── Distance_Table.xlsx               # distance matrices used as input
├── results/
│   ├── results.gdx                       # raw GAMS solution
│   ├── facilities.xlsx                   # opened plants
│   ├── warehouse.xlsx                    # opened warehouses and sizes
│   ├── production.xlsx                   # plant → warehouse flows
│   ├── scenarios.xlsx                    # 4 / 5 / 6 / 7 / 10 warehouse scenarios
│   └── figures/                          # result tables and network figure
├── REPORT.md                             # short project report
├── LICENSE
└── README.md
```

## How to run

### Option 1: GAMS

1. Install [GAMS](https://www.gams.com/download/) with a MIP solver (e.g. CPLEX or CBC).
2. Open `model/supply_chain_network_design.gms` and run it.
3. Results are written to `results.gdx` and shown in the listing (`z.l`, `x.l`, `y.l`, `H.l`, `r.l`).

> The last lines call `gdxxrw.exe` to export results to Excel. It is **Windows-only**; on Linux/macOS comment those lines out and read `results.gdx` directly.

To reproduce the scenarios, change the warehouse bounds in the model:

```gams
limit_2 .. sum((i,w), y(i,w)) =g= 5 ;   * minimum number of warehouses
limit_3 .. sum((i,w), y(i,w)) =l= 7 ;   * maximum number of warehouses
```

### Option 2: Python (no GAMS licence needed)

```bash
cd model
pip install -r requirements.txt
python verify_with_python.py supply_chain_network_design.gms            # base case (5–7 warehouses)
python verify_with_python.py supply_chain_network_design.gms 10 10      # exactly 10 warehouses
```

The script reads the data directly from the `.gms` file, rebuilds the same MILP, and solves it with HiGHS. It reproduces the base case and all five scenario costs in the table above.

To also draw the network figure, install `matplotlib` and add an output path:

```bash
python verify_with_python.py supply_chain_network_design.gms 5 7 network.png
```

## Limitations

- Deterministic model: demand, costs and capacities are assumed known.
- Single product, single time period.
- Distance (km) is used directly as the per-unit transport cost.
- Disruption risk, shortage penalties and sustainability objectives are not implemented.

## Possible extensions

- Stochastic demand and disruption risk
- Multi-product and multi-period planning
- Carbon-emission objective (multi-objective optimization)
- Real road distances and vehicle cost instead of the distance proxy

## License

The code is released under the [MIT License](LICENSE).

## Contact

**Nijat Aliyev** · Industrial Engineering
GitHub: [@your-username](https://github.com/your-username)
