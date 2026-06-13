# Healthcare Sales Force Effectiveness Analysis

## Overview
An end-to-end analytics project simulating a pharma sales force effectiveness (SFE) engagement — analyzing sales rep call activity, physician targeting, and prescription (Rx) trends across territories and products to identify performance gaps and growth opportunities.

## Tech Stack
- **Database:** MySQL
- **Analysis & Dashboard:** Google Sheets (Pivot Tables, Slicers, Scorecards, Charts)
- **Data Generation:** Python (Faker, Pandas, NumPy) — synthetic dataset mimicking real pharma CRM/Rx data structures

## Dataset
6 relational tables, ~20,000 rows total:
| Table | Description | Rows |
|---|---|---|
| territories | Sales territories & regions | 15 |
| sales_reps | Rep details, experience level | 40 |
| products | Product catalog (5 pharma products) | 5 |
| physicians | Physician profiles, segment (High/Med/Low), specialty | 200 |
| call_activity | Rep visit logs (date, product discussed, duration) | 8,000 |
| rx_data | Monthly prescription volume & value per physician/product | 12,000 |

## Schema (Entity Relationships)
- Each sales rep belongs to one territory
- Each physician belongs to one territory and has a preferred product
- call_activity links reps → physicians → products (transactional log)
- rx_data tracks monthly Rx units/value per physician-product (fact table)

## Approach
1. Designed normalized schema with referential integrity (FK relationships validated via integrity checks)
2. Built SQL views (`vw_master`, `vw_monthly_calls`) to flatten and align data at consistent grain (daily calls aggregated to monthly to match Rx reporting cadence)
3. Wrote analytical queries for 5 key metrics using CTEs, joins, and conditional aggregation
4. Exported results to Google Sheets and built an interactive dashboard with pivot tables, charts, slicers, and scorecards

## Key Metrics
1. **Rx Growth Rate (%)** — month-over-month prescription growth per physician/product
2. **Call Effectiveness Ratio** — Rx units generated per rep call, by territory
3. **Physician Segment Penetration** — % of High/Medium/Low segment physicians covered by calls
4. **Territory Market Share** — product-wise revenue share within each territory
5. *(Rep Productivity — optional extension)*

## Dashboard
![Dashboard Overview](screenshots/dashboard_overview.png)

Interactive features:
- Product and Territory slicers dynamically filter Rx growth trend and call effectiveness charts
- Scorecards for Total Rx Value (live, slicer-responsive)
- Static annual benchmarks for Market Share and Segment Penetration (different data granularity)

## Key Insights
- Achieved 100% physician call coverage across all segments (High/Medium/Low) in FY2024
- Identified territories with high call volume but below-average Rx-per-call ratio — potential targeting inefficiency
- Market share is concentrated in 2-3 products across most territories, suggesting diversification opportunity
- Rx growth shows significant month-to-month volatility, particularly for lower-base physician-product combinations

## Repository Structure
```
├── sql/
│   ├── 01_schema_and_import.sql
│   ├── 02_views.sql
│   └── 03_metric_queries.sql
├── data/
│   └── sample_data/ (subset CSVs)
├── Sales_Analysis.xlsx
├── screenshots/
│   └── dashboard_overview.png
└── README.md
```

## Limitations & Future Improvements
- Data is synthetic; real-world Rx data would include competitor products for true market share calculation
- Rep-to-Rx attribution isn't directly possible at the transaction level (call_activity and rx_data have different grains) — territory-level attribution used as a practical proxy
- Could extend with rep productivity scoring and what-if territory realignment scenarios
