
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (
    SELECT 
        "gtfsId" as id, lon,lat, name, city, wheelchair_boarding
    FROM {{ ref("smmag_line_stops") }}  AS S
    INNER join {{ ref("stops") }} AS S2 ON S2.stop_code = s.code
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
