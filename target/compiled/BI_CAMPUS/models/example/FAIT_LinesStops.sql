/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (
    SELECT 
        "gtfsId" as stop_id, line_id
    FROM "tag"."dbt"."smmag_line_stops"  AS S
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null