view: certification {
  sql_table_name: `job-posting-api-388303.core.certification`
    ;;

  dimension: cert_name {
    type: string
    sql: ${TABLE}.cert_name ;;
  }

  dimension: pass {
    type: number
    sql: ${TABLE}.pass ;;
  }

  dimension: pass_ratio {
    type: number
    sql: ${TABLE}.pass_ratio ;;
  }

  dimension: take {
    type: number
    sql: ${TABLE}.take ;;
  }

  dimension: test_year {
    type: number
    sql: ${TABLE}.test_year ;;
  }

  measure: count {
    type: count
    drill_fields: [cert_name]
  }
}
