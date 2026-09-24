# Midwest Airbnb Listings: Data Dictionary

**Dataset:** `listings` table in `midwest_airbnb.db` (SQLite), 14,887 rows and 29 columns
**Source:** Inside Airbnb (https://insideairbnb.com/get-the-data/), the detailed `listings.csv.gz` file for each of three regions: Chicago (snapshot 2026-07-20), Columbus (snapshot 2026-07-23), and Twin Cities MSA (snapshot 2026-07-21). Column meanings follow Inside Airbnb's data dictionary and assumptions (https://insideairbnb.com/data-assumptions/).
**Course:** ISA 401, Miami University

> One row is one listing that showed a nightly price on the snapshot date; listings with no price were dropped. Empty cells are stored as SQL `NULL`.

---

## Field Definitions

| Field | Type | Description |
|---|---|---|
| `city` | text | Which Inside Airbnb region the listing came from: `Chicago` (7,439 rows), `Columbus` (2,587), or `Twin Cities` (4,861). The Twin Cities file covers the Minneapolis-St. Paul metro area, not just the two cities. |
| `snapshot_date` | text | Date Inside Airbnb compiled the file, stored as an ISO text string, not a date: `2026-07-20` for Chicago, `2026-07-23` for Columbus, `2026-07-21` for Twin Cities. Every row of a city shares the same value. |
| `id` | text | Airbnb's listing id. Unique across the table (14,887 distinct values). Stored as text even though it looks numeric, so compare it to a quoted string. |
| `name` | text | Listing title as shown on Airbnb (for example "Tiny Studio Apartment 94 Walk Score"). Never empty. |
| `host_id` | text | Airbnb's id for the host. 6,970 distinct hosts, so many hosts run several listings; count distinct `host_id` to count hosts. Stored as text. |
| `host_name` | text | Host's first name(s) as shown on Airbnb (for example `Rebecca`, `Shar And Robert`). Not unique; use `host_id` to identify a host. `NULL` for 25 rows. |
| `host_since` | text | Date the host joined Airbnb. **Empty in every row (all 14,887 are `NULL`)**, so it cannot be used to answer questions. |
| `host_is_superhost` | text | Whether the host has Airbnb Superhost status: `t` (true) or `f` (false), stored as one-letter text, not a boolean. `NULL` for 25 rows. |
| `neighbourhood` | text | Neighborhood of the listing, from Inside Airbnb's `neighbourhood_cleansed` column (geocoded from latitude/longitude, for example `Hyde Park`, `West Town`, `Lincoln Park`). 119 distinct values across the three cities; always pair it with `city`. |
| `latitude` | real | Latitude of the listing in decimal degrees (about 41.8 for Chicago). Airbnb shifts locations by up to about 150 m for privacy, so it is approximate. |
| `longitude` | real | Longitude of the listing in decimal degrees (about -87.6 for Chicago); negative because the cities are west of Greenwich. Approximate, like `latitude`. |
| `property_type` | text | Host-selected property type, more detailed than `room_type`, for example `Entire rental unit`, `Private room in condo`, `Room in boutique hotel`. 62 distinct values. |
| `room_type` | text | Airbnb's four listing categories: `Entire home/apt` (11,652 rows), `Private room` (2,951), `Hotel room` (246), or `Shared room` (38). |
| `accommodates` | integer | Maximum number of guests the listing can hold, for example 1, 2, 4. Use this for questions about group size ("host a party of ten" means `accommodates >= 10`). Never `NULL`. |
| `bedrooms` | real | Number of bedrooms (for example 1, 2, 3). `NULL` for 2,976 rows, often studios or listings where the host left it blank; exclude `NULL`s rather than treating them as 0. |
| `beds` | real | Number of beds. `NULL` for 668 rows. |
| `bathrooms_text` | text | Bathrooms as free text, for example `1 bath`, `2 baths`, `1 shared bath`, `1 private bath`, `Half-bath`. 33 distinct values; it is text, so it cannot be summed or averaged without parsing. `NULL` for 71 rows. |
| `price` | real | Nightly price in U.S. dollars on the snapshot date, with the dollar sign and commas removed. Ranges from 2.56 to 11,412; never `NULL` (rows without a price were dropped). The extreme values skew averages, so medians are often more representative. |
| `minimum_nights` | integer | Minimum number of nights a guest must book (for example 2, 3, 32, 180). Values of 30 or more mark monthly or long-term rentals. `NULL` for 15 rows. |
| `availability_365` | integer | Number of nights the listing is available to book in the next 365 days, from 0 to 365, as of the snapshot date. 0 can mean fully booked or blocked by the host. |
| `number_of_reviews` | integer | Total number of reviews the listing has received over its lifetime. 0 for listings never reviewed. |
| `number_of_reviews_ltm` | integer | Number of reviews in the last twelve months before the snapshot date ("ltm" = last twelve months). A proxy for recent activity. |
| `first_review` | text | Date of the listing's first review, as ISO text (`YYYY-MM-DD`), for example `2009-07-03`. `NULL` for the 1,761 listings with no reviews. |
| `last_review` | text | Date of the listing's most recent review, as ISO text (`YYYY-MM-DD`), for example `2026-06-30`. `NULL` for the 1,761 listings with no reviews. |
| `review_scores_rating` | real | Average overall guest rating on a 0–5 scale (for example 4.99, 4.74). `NULL` for the 1,761 listings with no reviews. |
| `reviews_per_month` | real | Average number of reviews per month over the listing's lifetime (for example 1.91). `NULL` for the 1,761 listings with no reviews. |
| `instant_bookable` | text | Whether guests can book without host approval. **Empty in every row (all 14,887 are `NULL`)**, so it cannot be used to answer questions. |
| `estimated_revenue_l365d` | real | Inside Airbnb's estimated revenue in U.S. dollars over the last 365 days ("l365d"), roughly the nightly price times the estimated number of booked nights. An estimate, not reported earnings. Never `NULL`. |
| `amenities_count` | integer | Number of amenities the listing advertises (Wi-Fi, kitchen, parking, etc.), for example 27, 41, 47. Not an Inside Airbnb column: computed for this course by counting the items in each listing's `amenities` list. |
