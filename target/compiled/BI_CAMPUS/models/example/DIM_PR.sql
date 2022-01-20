/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with relais as (
    SELECT 
        "LIBELLE" as nom_parking, 
        REPLACE(UNNEST(STRING_TO_ARRAY("LIGNES",',')),'_',':') as lines_id, 
        lon as longitude, 
        lat as latitude
    FROM "tag"."dbt"."Relais"
    )

select *
from relais

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null