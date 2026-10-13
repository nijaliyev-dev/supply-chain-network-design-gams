# Project Report: Supply Chain Network Design for TYS

**Author:** Nijat Aliyev · **Supervisor:** Prof. Dr. Selin Soner Kara
**Institution:** Yıldız Technical University, Industrial Engineering · **Date:** January 2025
**Tools:** GAMS (MIP), Excel, Python (SciPy/HiGHS for verification)

## 1. Problem

TYS produces gypsum-based construction materials in Azerbaijan and serves customers in 13 regions. Management wants to know **where to open plants and warehouses, and what warehouse size to build**, so that total network cost is minimal. Company policy limits the network to 4–5 plants and a restricted number of warehouses.

## 2. Approach

A three-echelon, capacitated facility-location model (plants → warehouses → customer zones) was formulated as a mixed-integer linear program and solved in GAMS.

- **Candidates:** 13 plant sites, 13 warehouse sites (3 sizes each), 13 customer zones
- **Decisions:** plant opening, warehouse opening and size, customer-to-warehouse assignment, plant-to-warehouse flows
- **Costs:** fixed opening costs, production cost, warehouse handling cost, transport cost (distance-based)
- **Constraints:** single sourcing, plant and warehouse capacities, flow balance, limits on the number of open facilities

## 3. Results

**Optimal total cost: 19,252,800** (base case, 5–7 warehouses allowed). Total demand served: 1,091,000 units.

| Element | Decision |
|---|---|
| Plants | Baku, Khankandi, Qubadli, Lachin, Ganja |
| Large warehouses | Baku, Lachin |
| Medium warehouses | Khankandi, Qubadli, Nakhchivan, Ganja |
| Small warehouse | Shamakhi |

Findings:

1. The solution places capacity close to the largest demand zones (Baku, Khankandi, Qubadli, Lachin). Most plants ship to the co-located warehouse; Baku supplies two warehouses and Khankandi supplies two.
2. Fixed costs are only about 0.5% of total cost (96,550 of 19,252,800). **Transport and handling drive the result**, so location choice matters far more than opening cost.
3. The model was independently re-solved in Python with a different solver and returned the same optimum, as well as the same cost for all five scenarios.

## 4. Scenario analysis

| Warehouses | Fixed cost | Total cost |
|:-:|--:|--:|
| 4 | 90,950 | 26,530,550 |
| 5 | 93,750 | 19,803,250 |
| 6 | 96,750 | 19,434,500 |
| 7 | 96,550 | 19,252,800 |
| 10 | 93,300 | 19,126,050 |

- Moving from 4 to 5 warehouses reduces cost by **25.4%**. Four warehouses cannot serve demand efficiently.
- From 5 to 7 warehouses the saving is a further 2.8%.
- Ten warehouses is the cheapest option (about 0.66% below the 7-warehouse base case). The thesis recommends 10; since the gain over 7 is small, management should weigh it against operating complexity that the model does not capture.

## 5. Conclusions and recommendations

- Open **5 plants and at least 7 warehouses** at the locations above; a network of 10 warehouses gives the lowest modelled cost.
- Concentrate large warehouses in the highest-demand hubs and use medium or small ones elsewhere.
- Improve route planning with GIS/routing software and consolidate shipments to reduce transport cost, which is the dominant cost.
- Use the Baku–Tbilisi–Kars railway and Baku port for wider regional distribution.

## 6. Limitations and future work

The model is deterministic, single-product and single-period, and uses distance as a proxy for transport cost. Future work: demand uncertainty and disruption risk, multi-product/multi-period planning, a carbon-emission objective, and real road-cost data.

## 7. Deliverables

| File | Description |
|---|---|
| `model/supply_chain_network_design.gms` | GAMS model |
| `model/verify_with_python.py` | Independent check of the results |
| `results/` | Solution files, scenario table, figures |
| `docs/` | Full thesis, presentation, poster |
