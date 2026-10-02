-- ============================================================
-- INDIAN ORCHARDS & FRUIT CROPS: SQL ANALYTICS DIAGNOSTIC
-- ============================================================

-- Query 1: Top 3 Districts by Yield (Tonnes/Ha) for Each Major Fruit Crop
-- Uses Window Function RANK() OVER (PARTITION BY crop ORDER BY ...)
WITH DistrictAvgYield AS (
    SELECT 
        state,
        district,
        crop,
        ROUND(AVG(area_hectares), 2) AS avg_area_ha,
        ROUND(AVG(production_tonnes), 2) AS avg_production_tonnes,
        ROUND(AVG(yield_tonnes_per_ha), 2) AS avg_yield_t_ha
    FROM fruit_apy
    GROUP BY state, district, crop
),
RankedDistricts AS (
    SELECT 
        state,
        district,
        crop,
        avg_area_ha,
        avg_production_tonnes,
        avg_yield_t_ha,
        RANK() OVER (PARTITION BY crop ORDER BY avg_yield_t_ha DESC) as yield_rank
    FROM DistrictAvgYield
)
SELECT yield_rank, crop, state, district, avg_area_ha, avg_production_tonnes, avg_yield_t_ha
FROM RankedDistricts
WHERE yield_rank <= 3
ORDER BY crop, yield_rank;


-- Query 2: Multi-Year Production Trajectory (2018 vs 2023 Growth)
SELECT 
    crop,
    SUM(CASE WHEN crop_year = 2018 THEN production_tonnes ELSE 0 END) AS prod_2018_tonnes,
    SUM(CASE WHEN crop_year = 2023 THEN production_tonnes ELSE 0 END) AS prod_2023_tonnes,
    ROUND(
        ((SUM(CASE WHEN crop_year = 2023 THEN production_tonnes ELSE 0 END) - 
          SUM(CASE WHEN crop_year = 2018 THEN production_tonnes ELSE 0 END)) * 100.0) / 
         SUM(CASE WHEN crop_year = 2018 THEN production_tonnes ELSE 0 END), 2
    ) AS production_growth_pct
FROM fruit_apy
GROUP BY crop
ORDER BY production_growth_pct DESC;


-- Query 3: State-Level Orchard Performance Summary & Yield Tier Distribution
SELECT 
    state,
    COUNT(DISTINCT district) AS total_districts,
    COUNT(DISTINCT crop) AS total_fruit_crops,
    ROUND(SUM(area_hectares), 2) AS total_cultivated_area_ha,
    ROUND(SUM(production_tonnes), 2) AS total_production_tonnes,
    ROUND(AVG(yield_tonnes_per_ha), 2) AS state_avg_yield_t_ha
FROM fruit_apy
GROUP BY state
ORDER BY total_production_tonnes DESC;
