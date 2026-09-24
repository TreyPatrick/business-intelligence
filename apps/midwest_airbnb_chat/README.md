# Midwest Airbnb Explorer

**Live app:** https://business-intelligence-fu38.onrender.com

Ask a question in plain English about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities, and get the SQL, a table, or a chart back.

> The app runs on Render's free tier, so it sleeps after 15 minutes. The first visit takes about a minute to wake it up.

## Data

- **Source:** [Inside Airbnb](https://insideairbnb.com/get-the-data/)
- **Snapshots:** Chicago 2026-07-20, Columbus 2026-07-23, Twin Cities 2026-07-21
- **Table:** `listings` in `data/midwest_airbnb.db` (14,887 rows, 29 columns)
- **Data dictionary:** `data/data_desc.md`
- **Query rules for the LLM:** `data/extra_instructions.md`

## Example questions

### 1. Do superhosts charge more per night than other hosts? Show it as a bar chart.
![Superhost vs. non-superhost prices](screenshots/q1.png)

### 2. Which 10 Chicago neighbourhoods earn the most estimated revenue per listing?
![Top Chicago neighbourhoods by revenue](screenshots/q2.png)

### 3. Compare the median nightly price by room type in each city.
![Median price by room type and city](screenshots/q3.png)



## Tech stack

Shiny, bslib, querychat, ellmer (OpenAI `gpt-5.6-luna`), RSQLite, deployed with Docker on Render.

## Author

Built by Trey Patrick for ISA 401, Miami University.