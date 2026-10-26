
-- ============================================================
-- QUESTION 1:
-- Find the top 5 highest-rated restaurants in Koramangala
-- that serve North Indian cuisine.
-- ============================================================

SELECT
    name,
    location,
    cuisines,
    rate,
    `approx_cost(for two people)` AS average_cost_for_two
FROM zomato
WHERE location LIKE '%Koramangala%'
  AND cuisines LIKE '%North Indian%'
  AND rate IS NOT NULL
ORDER BY rate DESC
LIMIT 5;


-- ============================================================
-- QUESTION 2:
-- Calculate the average cost for two people for each cuisine
-- and list the 3 most expensive cuisines in Bangalore.
-- ============================================================

SELECT
    cuisines,
    ROUND(AVG(`approx_cost(for two people)`), 2)
        AS average_cost_for_two,
    COUNT(*) AS total_restaurants
FROM zomato
WHERE `approx_cost(for two people)` IS NOT NULL
  AND cuisines IS NOT NULL
GROUP BY cuisines
ORDER BY average_cost_for_two DESC
LIMIT 3;


-- ============================================================
-- QUESTION 3:
-- Find restaurants that offer online delivery but have
-- a rating below 3.0.
-- ============================================================

SELECT
    name,
    location,
    cuisines,
    rate,
    `approx_cost(for two people)` AS average_cost_for_two,
    online_order
FROM zomato
WHERE LOWER(TRIM(online_order)) = 'yes'
  AND rate < 3.0
ORDER BY rate ASC;


-- ============================================================
-- QUESTION 4:
-- Segment restaurants into budget, mid-range, and premium
-- categories based on average cost for two.
-- Budget: below 400
-- Mid-range: 400 to 800, inclusive
-- Premium: above 800
-- Count restaurants in each segment.
-- ============================================================

SELECT
    market_segment,
    COUNT(*) AS total_restaurants
FROM (
    SELECT
        CASE
            WHEN `approx_cost(for two people)` < 400
                THEN 'Budget'
            WHEN `approx_cost(for two people)` <= 800
                THEN 'Mid-range'
            WHEN `approx_cost(for two people)` > 800
                THEN 'Premium'
        END AS market_segment
    FROM zomato
    WHERE `approx_cost(for two people)` IS NOT NULL
) AS RestaurantSegments
GROUP BY market_segment
ORDER BY
    CASE market_segment
        WHEN 'Budget' THEN 1
        WHEN 'Mid-range' THEN 2
        WHEN 'Premium' THEN 3
    END;


-- ============================================================
-- QUESTION 5:
-- Find the top 10 most popular restaurant chains by number
-- of outlets in the dataset.
--
-- Assumption:
-- Restaurants