

  create  table "tag"."dbt"."DIM_Distances__dbt_tmp"
  as (
    /*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (
    select s1."gtfsId" as id_stop1,
    s2."gtfsId" as id_stop2, 
    s1.line_id as id_line_stop1, 
    s2.line_id as id_line_stop2, 
    s1.name as name_stop1, 
    s2.name as name_stop2, 
    s1.lon lon_stop1, 
    s2.lon lon_stop2, 
    s1.lat lat_stop1, 
    s2.lat lat_stop2,
    wheelchair_boarding,
    public.calculate_distance(s1.lat, s1.lon, s2.lat, s2.lon, 'K') as distance
    from "tag"."dbt"."smmag_line_stops"  s1
    INNER join "tag"."dbt"."stops" AS S3 ON S3.stop_code = s1.code
    cross join "tag"."dbt"."smmag_line_stops"  s2
    where s1."gtfsId" <> s2."gtfsId" and s1.line_id <> s2.line_id 
    group by s1."gtfsId",s2."gtfsId", s1.line_id, s2.line_id,s1.name, 
    s2.name,  s1.lon, s2.lon, s1.lat, s2.lat,wheelchair_boarding 
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
  );