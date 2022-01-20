{{ config(materialized='table') }}

with seq_time as (
    SELECT
        distinct timelaps
    FROM {{ ref('updown_per_cluster_and_mode') }}
    WHERE timelaps <> 'ALL'
    GROUP BY timelaps
),
splited_timelaps as (
	select
	    sq.timelaps as timelaps_label,
	    cast (regexp_replace(split_part(sq.timelaps,'-', 1),'H',':')as text) as start_hour,
	    cast (regexp_replace(split_part(sq.timelaps,'-', 2),'H',':') as text)  as end_hour

	from seq_time sq
)


select
    row_number() over(order by sq.timelaps_label) as timelaps_id,
    sq.timelaps_label,
    sq.start_hour,
    sq.end_hour

from splited_timelaps sq