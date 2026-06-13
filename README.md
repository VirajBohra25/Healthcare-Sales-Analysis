# Healthcare Sales Force Effectiveness Analysis

## Overview
An end-to-end analytics project simulating a pharma sales force effectiveness (SFE) engagement — analyzing sales rep call activity, physician targeting, and prescription (Rx) trends across territories and products to identify performance gaps and growth opportunities.

## Tech Stack
- **Database:** MySQL
- **Analysis & Dashboard:** Google Sheets (Pivot Tables, Slicers, Scorecards, Charts)
- **Data Generation:** Python (Faker, Pandas, NumPy) using Claude AI — synthetic dataset mimicking real pharma CRM/Rx data structures

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
1. Designed normalized schema with referential integrity
2. Built SQL views (`vw_master`, `vw_monthly_calls`) to flatten and align data at consistent grain
3. Wrote analytical queries for 4 key metrics using views, joins, and conditional aggregation
4. Exported results to Google Sheets and built an interactive dashboard with pivot tables, charts, slicers, and scorecards

## Key Metrics
1. **Rx Growth Rate (%)** — month-over-month prescription growth per physician/product
2. **Call Effectiveness Ratio** — Rx units generated per rep call, by territory
3. **Physician Segment Penetration** — % of High/Medium/Low segment physicians covered by calls
4. **Territory Market Share** — product-wise revenue share within each territory


Interactive features:
- Product,Territory and Quarter slicers dynamically filter Total Rx (value). Hence helping visualise quarterwise sales of different products in different territories
- Scorecard for Total Rx Value (live, slicer-responsive),static scorecard for average growth percentage

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
- Data is synthetic; real-world Rx data would include competitor products for true market share calculation.
- Could extend with rep productivity scoring and what-if territory realignment scenarios.
