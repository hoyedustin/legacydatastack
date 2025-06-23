{{ config(materialized='view') }}

SELECT 
    *, 
    NULL AS EXTRA_COLUMN
FROM "LEGACY_RDA"."REPORTING"."LAND_GORILLA_WATCHLIST_REPORT"