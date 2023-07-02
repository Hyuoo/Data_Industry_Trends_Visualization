connection: "job-posting-looker"
# `job-posting-api-388303.core.recruit`
# include all the views
include: "/looker/views/*.view"
include: "/looker/dashboards/*.dashboard"

datagroup: jpd_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: jpd_default_datagroup

explore: certification {}

explore: google_trend {}

explore: datajob {}

explore: recruit {}
