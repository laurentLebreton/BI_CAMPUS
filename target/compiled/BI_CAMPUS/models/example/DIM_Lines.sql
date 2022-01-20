/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (
    SELECT L."gtfsId",
        LEFT(L."gtfsId",
            3) AS RESEAU,
        "shortName",
        "longName" AS NOM,
        MODE,
        TYPE,
        COUNT(S."line_id") as nb_arret,
        SUM (COALESCE(wheelchair_boarding,0)) as nb_arret_PMR, color,"textColor"
    FROM "tag"."dbt"."smmag_line_stops"  AS S
    INNER JOIN "tag"."dbt"."stops" AS S2 ON S2.stop_code = s.code
    RIGHT JOIN  "tag"."dbt"."smmag_lines" AS L  ON L."id" = S."line_id"
    GROUP BY L."gtfsId",
        RESEAU,
        NOM,
        MODE,
        TYPE,
        "shortName" , color,"textColor"
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null