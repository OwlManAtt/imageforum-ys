#!/bin/bash
tables=( jump_page cron_tab board avatar timezone datetime_format staff_permission staff_group board_category )

pg_dump -s -U nevans godless > postgres_ddl.sql

for table in  ${tables[@]}
do
    pg_dump -a -U nevans --table=$table godless > pgsql_data/${table}.sql
done
