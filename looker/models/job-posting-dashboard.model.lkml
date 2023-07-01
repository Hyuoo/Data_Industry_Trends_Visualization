connection: "job-posting-looker"

# include all the views
include: "../views/*.view"
include: "../dashboards/*.dashboard"

datagroup: jpd_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: jpd_default_datagroup

explore: certification {}

explore: google_trend {}

explore: datajob {}

explore: recruit {}
