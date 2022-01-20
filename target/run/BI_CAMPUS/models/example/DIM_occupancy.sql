

  create  table "tag"."dbt"."DIM_occupancy__dbt_tmp"
  as (
    /*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (
    select "timeSlot" as timeslot,occupancy,right("routeDirection", strpos("routeDirection", ':') - 3)  as direction,
    left("routeDirection", strpos("routeDirection", ':') +1) as id_line ,stop_id
    stop_id from "tag"."dbt"."smmag_stop_occupancy"
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
  );