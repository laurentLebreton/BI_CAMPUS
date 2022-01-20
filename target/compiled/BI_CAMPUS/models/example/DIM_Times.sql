/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (
    select id, arrival_time, departure_time  from "tag"."dbt"."stop_times" as s1
    inner join "tag"."dbt"."smmag_line_stops" as s2 on cast(s1.stop_id as varchar) = s2.code 
    group by id, arrival_time, departure_time
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null