view: datajob {
  sql_table_name: `job-posting-api-388303.core.datajob`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: apply_cnt {
    type: number
    sql: ${TABLE}.apply_cnt ;;
  }

  dimension: exp_max {
    type: number
    sql: ${TABLE}.exp_max ;;
  }

  dimension: exp_min {
    type: number
    sql: ${TABLE}.exp_min ;;
  }

  dimension: exp_name {
    type: string
    sql: ${TABLE}.exp_name ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: industry_category {
    type: string
    sql: ${TABLE}.industry_category ;;
  }

  dimension: job_name {
    type: string
    sql: ${TABLE}.job_name ;;
  }

  dimension: location_name {
    type: string
    sql: ${TABLE}.location_name ;;
  }

  dimension: posting_date {
    type: string
    sql: ${TABLE}.posting_date ;;
  }

  dimension: read_cnt {
    type: number
    sql: ${TABLE}.read_cnt ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: wide_location {
    type: string
    sql: ${TABLE}.wide_location ;;
  }

  measure: count {
    type: count
    drill_fields: [id, exp_name, location_name, job_name]
  }

  measure: count_distinct {
    type: count_distinct
    drill_fields: [id]
  }

}
