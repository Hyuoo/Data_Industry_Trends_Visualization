view: google_trend {
  sql_table_name: `job-posting-api-388303.core.google_trend`
    ;;

  dimension: count_google_trend {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: kw {
    type: string
    sql: ${TABLE}.kw ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
