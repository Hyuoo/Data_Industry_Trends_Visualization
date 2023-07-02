- dashboard: recruit
  title: recruit
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: chwVyh8rvjk7IRagKQhBRP
  elements:
  - title: Untitled
    name: Untitled
    model: job-posting-dashboard
    explore: recruit
    type: single_value
    fields: [recruit.count_tmp]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 전체 채용 공고 수
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 7
    height: 3
  - name: 데이터 직군 별 비율
    title: 데이터 직군 별 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_pie
    fields: [recruit.count_tmp, recruit.tag]
    filters:
      recruit.tag: 데이터%
    sorts: [recruit.count_tmp desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, description: '', label: data_group, value_format: !!null '',
        value_format_name: !!null '', calculation_type: group_by, dimension: data_group,
        args: [recruit.tag, [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직군, filter: '데이터엔지니어,데이터분석가,데이터사이언티스트'}, !ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직군 외, filter: "-데이터분석가,-데이터사이언티스트,-데이터엔지니어"}], !!null ''],
        _kind_hint: dimension, _type_hint: string}]
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: recruit.count_tmp, id: 경력
              - recruit.count_tmp, name: 경력}, {axisId: recruit.count_tmp, id: 경력무관
              - recruit.count_tmp, name: 경력무관}, {axisId: recruit.count_tmp, id: 신입
              - recruit.count_tmp, name: 신입}, {axisId: recruit.count_tmp, id: 신입/경력
              - recruit.count_tmp, name: 신입/경력}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: false
    y_axis_zoom: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    font_size: 11px
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    label_color: ["#062F4F"]
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: []
    listen: {}
    row: 10
    col: 12
    width: 8
    height: 7
  - name: 산업 별 채용 수
    title: 산업 별 채용 수
    model: job-posting-dashboard
    explore: datajob
    type: looker_column
    fields: [datajob.industry_category, datajob.count_distinct, datajob.tag]
    pivots: [datajob.tag]
    sorts: [datajob.tag desc, datajob.count_distinct desc 3]
    limit: 500
    column_limit: 50
    row_total: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: datajob.count_distinct,
            id: 데이터엔지니어 - datajob.count_distinct, name: 데이터엔지니어}, {axisId: datajob.count_distinct,
            id: 데이터사이언티스트 - datajob.count_distinct, name: 데이터사이언티스트}, {axisId: datajob.count_distinct,
            id: 데이터분석가 - datajob.count_distinct, name: 데이터분석가}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 0,
        type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    series_types: {}
    series_labels: {}
    reference_lines: []
    trend_lines: []
    x_axis_label_rotation:
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    value_labels: legend
    label_type: labPer
    hidden_fields: []
    hidden_points_if_no: []
    listen: {}
    row: 36
    col: 0
    width: 9
    height: 8
  - name: IT·웹·통신 상세 업종 채용 수
    title: IT·웹·통신 상세 업종 채용 수
    model: job-posting-dashboard
    explore: datajob
    type: looker_column
    fields: [datajob.industry, datajob.count_distinct, datajob.tag]
    pivots: [datajob.tag]
    filters:
      datajob.industry_category: IT·웹·통신
    sorts: [datajob.tag desc, datajob.count_distinct desc 3]
    limit: 500
    column_limit: 50
    row_total: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: datajob.count_distinct,
            id: 데이터엔지니어 - datajob.count_distinct, name: 데이터엔지니어}, {axisId: datajob.count_distinct,
            id: 데이터사이언티스트 - datajob.count_distinct, name: 데이터사이언티스트}, {axisId: datajob.count_distinct,
            id: 데이터분석가 - datajob.count_distinct, name: 데이터분석가}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    defaults_version: 1
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    listen: {}
    row: 36
    col: 9
    width: 9
    height: 8
  - name: 데이터 직종 채용 키워드 30
    title: 데이터 직종 채용 키워드 30
    model: job-posting-dashboard
    explore: datajob
    type: looker_bar
    fields: [datajob.job_name, datajob.count_distinct, datajob.tag]
    pivots: [datajob.tag]
    sorts: [datajob.tag desc, datajob.count_distinct desc 3]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, label: tt, value_format: !!null '',
        value_format_name: Default formatting, calculation_type: running_row_total,
        table_calculation: tt, args: [datajob.count_distinct], _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: 데이터분석가 - datajob.count_distinct,
            id: 데이터분석가 - datajob.count_distinct, name: 데이터분석가}, {axisId: 데이터사이언티스트
              - datajob.count_distinct, id: 데이터사이언티스트 - datajob.count_distinct, name: 데이터사이언티스트},
          {axisId: 데이터엔지니어 - datajob.count_distinct, id: 데이터엔지니어 - datajob.count_distinct,
            name: 데이터엔지니어}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '30'
    series_types: {}
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 19
    col: 7
    width: 7
    height: 15
  - name: 데이터 직종 채용 키워드 30 (비율)
    title: 데이터 직종 채용 키워드 30 (비율)
    model: job-posting-dashboard
    explore: datajob
    type: looker_bar
    fields: [datajob.job_name, datajob.count_distinct, datajob.tag]
    pivots: [datajob.tag]
    sorts: [datajob.tag desc, datajob.count_distinct desc 3]
    limit: 500
    column_limit: 50
    row_total: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: 데이터분석가 - datajob.count_distinct,
            id: 데이터분석가 - datajob.count_distinct, name: 데이터분석가}, {axisId: 데이터사이언티스트
              - datajob.count_distinct, id: 데이터사이언티스트 - datajob.count_distinct, name: 데이터사이언티스트},
          {axisId: 데이터엔지니어 - datajob.count_distinct, id: 데이터엔지니어 - datajob.count_distinct,
            name: 데이터엔지니어}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '30'
    series_types: {}
    column_group_spacing_ratio: 0.2
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    defaults_version: 1
    listen: {}
    row: 19
    col: 14
    width: 10
    height: 15
  - name: 데이터 직군 비율
    title: 데이터 직군 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_pie
    fields: [recruit.count_tmp, data_group]
    sorts: [data_group desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, description: '', label: data_group, value_format: !!null '',
        value_format_name: !!null '', calculation_type: group_by, dimension: data_group,
        args: [recruit.tag, [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직군, filter: '데이터엔지니어,데이터분석가,데이터사이언티스트'}, !ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직군 외, filter: "-데이터분석가,-데이터사이언티스트,-데이터엔지니어"}], !!null ''],
        _kind_hint: dimension, _type_hint: string}]
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: recruit.count_tmp, id: 경력
              - recruit.count_tmp, name: 경력}, {axisId: recruit.count_tmp, id: 경력무관
              - recruit.count_tmp, name: 경력무관}, {axisId: recruit.count_tmp, id: 신입
              - recruit.count_tmp, name: 신입}, {axisId: recruit.count_tmp, id: 신입/경력
              - recruit.count_tmp, name: 신입/경력}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: false
    y_axis_zoom: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    font_size: 11px
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    label_color: ["#062F4F"]
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: []
    listen: {}
    row: 10
    col: 0
    width: 8
    height: 7
  - name: data job ratio_table
    title: data job ratio_table
    model: job-posting-dashboard
    explore: recruit
    type: looker_grid
    fields: [recruit.count_tmp, data_group]
    sorts: [recruit.count_tmp desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, description: '', label: data_group, value_format: !!null '',
        value_format_name: !!null '', calculation_type: group_by, dimension: data_group,
        args: [recruit.tag, [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직군, filter: '데이터엔지니어,데이터분석가,데이터사이언티스트'}, !ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직군 외, filter: "-데이터분석가,-데이터사이언티스트,-데이터엔지니어"}], !!null ''],
        _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      data_group: 분류
      recruit.count_tmp: 공고수
    series_column_widths:
      recruit.count_tmp: 80
    series_cell_visualizations:
      recruit.count_tmp:
        is_active: false
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: recruit.count_tmp, id: 경력
              - recruit.count_tmp, name: 경력}, {axisId: recruit.count_tmp, id: 경력무관
              - recruit.count_tmp, name: 경력무관}, {axisId: recruit.count_tmp, id: 신입
              - recruit.count_tmp, name: 신입}, {axisId: recruit.count_tmp, id: 신입/경력
              - recruit.count_tmp, name: 신입/경력}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: false
    y_axis_zoom: false
    trellis: ''
    stacking: ''
    legend_position: center
    font_size: 11px
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    label_color: ["#062F4F"]
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: []
    title_hidden: true
    listen: {}
    row: 10
    col: 8
    width: 4
    height: 7
  - name: 직종 별 경력 모집 비율
    title: 직종 별 경력 모집 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_column
    fields: [recruit.tag, recruit.count_tmp, recruit.exp_name]
    pivots: [recruit.exp_name]
    filters:
      recruit.tag: "-NULL"
    sorts: [recruit.exp_name, recruit.count_tmp desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: right
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: recruit.count_tmp, id: 경력
              - recruit.count_tmp, name: 경력}, {axisId: recruit.count_tmp, id: 경력무관
              - recruit.count_tmp, name: 경력무관}, {axisId: recruit.count_tmp, id: 신입
              - recruit.count_tmp, name: 신입}, {axisId: recruit.count_tmp, id: 신입/경력
              - recruit.count_tmp, name: 신입/경력}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    font_size: 11px
    label_color: ["#062F4F"]
    defaults_version: 1
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 7
    width: 17
    height: 10
  - name: IT 직종 전체 키워드
    title: IT 직종 전체 키워드
    model: job-posting-dashboard
    explore: recruit
    type: looker_grid
    fields: [recruit.job_name, recruit.count_tmp]
    sorts: [recruit.count_tmp desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      recruit.job_name: 키워드
      recruit.count: count
      recruit.count_tmp: Count
    series_column_widths:
      recruit.job_name: 141
    series_cell_visualizations:
      recruit.count:
        is_active: true
      recruit.count_tmp:
        is_active: true
        value_display: true
        palette:
          palette_id: simplifica-sequential-0
          collection_id: simplifica
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    listen: {}
    row: 19
    col: 0
    width: 7
    height: 15
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      - - -

      ### 채용 키워드
    row: 17
    col: 0
    width: 24
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      - - -

      ### 산업 별 채용
    row: 34
    col: 0
    width: 24
    height: 2
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |+
      ### 사람인 API를 이용한 채용 데이터 분석
      - 데이터 엔지니어 + 신입 관점
      - 데이터 분석가의 경우 "데이터분석" 키워드 외에 "시각화" 부분까지 포함 함.
      - 데이터 사이언티스트의 경우 "인공지능", "머신러닝/딥러닝"의 결과를 포함 함.
      - 데이터 분야에 입문하는 신입 관점에서 필요한 데이터들을 시각화.

      ※ 기간에 따른 데이터 분포가 매우 편파적이어서 채용 추이 또는 전망에 대한 분석은 불가능.

      - 검색량이나 자격증으로 분야에 대한 관심도를 파악.

    row: 3
    col: 0
    width: 7
    height: 7
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      - - -

      ### 근무지역 별 채용
    row: 52
    col: 0
    width: 24
    height: 2
  - title: IT 전체 근무 지역 비율
    name: IT 전체 근무 지역 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_pie
    fields: [recruit.wide_location, recruit.count_tmp]
    sorts: [recruit.count_tmp desc 0]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    row: 54
    col: 0
    width: 9
    height: 8
  - title: 데이터직종 별 산업 비교
    name: 데이터직종 별 산업 비교
    model: job-posting-dashboard
    explore: datajob
    type: looker_donut_multiples
    fields: [datajob.count_distinct, datajob.industry_category, datajob.tag]
    pivots: [datajob.industry_category]
    sorts: [datajob.industry_category desc, datajob.tag desc]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 14
    hide_legend: false
    hidden_pivots: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 44
    col: 0
    width: 18
    height: 8
  - title: IT 전체 근무 지역 비율 (서울)
    name: IT 전체 근무 지역 비율 (서울)
    model: job-posting-dashboard
    explore: recruit
    type: looker_pie
    fields: [recruit.count_tmp, recruit.location_name]
    filters:
      recruit.wide_location: 서울전체
      recruit.location_name: "-미분류"
    sorts: [recruit.count_tmp desc 0]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 54
    col: 9
    width: 9
    height: 8
  - title: 산업 별 데이터직종 비율
    name: 산업 별 데이터직종 비율
    model: job-posting-dashboard
    explore: datajob
    type: looker_donut_multiples
    fields: [datajob.industry_category, datajob.tag, datajob.count_distinct]
    pivots: [datajob.tag]
    sorts: [datajob.tag desc, datajob.count_distinct desc 0]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 12
    hidden_pivots: {}
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 36
    col: 18
    width: 6
    height: 16
  - title: 데이터직종 근무 지역 비율 (서울)
    name: 데이터직종 근무 지역 비율 (서울)
    model: job-posting-dashboard
    explore: datajob
    type: looker_pie
    fields: [datajob.count_distinct, datajob.location_name]
    filters:
      datajob.wide_location: 서울전체
      datajob.location_name: "-미분류"
    sorts: [datajob.count_distinct desc 0]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 62
    col: 9
    width: 9
    height: 8
  - title: IT전체/데이터직종 지역 비율
    name: IT전체/데이터직종 지역 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_bar
    fields: [recruit.wide_location, recruit.count_tmp, dg_2]
    pivots: [dg_2]
    sorts: [dg_2, recruit.count_tmp desc 2]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: dimension, description: '', label: dg, value_format: !!null '',
        value_format_name: !!null '', calculation_type: group_by, dimension: dg, args: [
          recruit.tag, [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: dd,
              filter: 데이터%}, !ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: nd, filter: "-데이터%"}], !!null ''], _kind_hint: dimension, _type_hint: string},
      {category: dimension, description: '', label: dg, value_format: !!null '', value_format_name: !!null '',
        calculation_type: group_by, dimension: dg_1, args: [dg, [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직종, filter: 데이터%}, !ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직종 외, filter: "-데이터%"}], !!null ''], _kind_hint: dimension,
        _type_hint: string}, {category: dimension, description: '', label: dg, value_format: !!null '',
        value_format_name: !!null '', calculation_type: group_by, dimension: dg_2,
        args: [recruit.tag, [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직종, filter: 데이터%}, !ruby/hash:ActiveSupport::HashWithIndifferentAccess {
              label: 데이터직종 외, filter: "-데이터%"}], !!null ''], _kind_hint: dimension,
        _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: true
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: 데이터직종 - recruit.count_tmp,
            id: 데이터직종 - recruit.count_tmp, name: 데이터직종}, {axisId: 데이터직종 외 - recruit.count_tmp,
            id: 데이터직종 외 - recruit.count_tmp, name: 데이터직종 외}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '5'
    font_size: '12'
    series_types: {}
    reference_lines: []
    trend_lines: []
    defaults_version: 1
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    show_null_points: true
    value_labels: legend
    label_type: labPer
    interpolation: linear
    listen: {}
    row: 54
    col: 18
    width: 6
    height: 16
  - title: 데이터직종 근무 지역 비율
    name: 데이터직종 근무 지역 비율
    model: job-posting-dashboard
    explore: datajob
    type: looker_pie
    fields: [datajob.wide_location, datajob.count_distinct]
    sorts: [datajob.count_distinct desc 0]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 62
    col: 0
    width: 9
    height: 8
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      - - -

      ### 자격증 응시
    row: 70
    col: 0
    width: 24
    height: 2
  - name: " (6)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      - - -

      ### 트렌드 분석
    row: 90
    col: 0
    width: 24
    height: 2
  - title: 상위 자격증 응시자/합격자 수
    name: 상위 자격증 응시자/합격자 수
    model: job-posting-dashboard
    explore: certification
    type: looker_column
    fields: [take, certification.test_year, certification.cert_name, pass]
    pivots: [certification.cert_name]
    filters:
      certification.cert_name: sql 전문가,데이터분석 전문가,리눅스마스터 1급
    sorts: [certification.test_year, certification.cert_name desc, take desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: take, value_format: !!null '',
        value_format_name: !!null '', based_on: certification.take, _kind_hint: measure,
        measure: take, type: sum, _type_hint: number}, {category: measure, expression: !!null '',
        label: pass, value_format: !!null '', value_format_name: !!null '', based_on: certification.pass,
        _kind_hint: measure, measure: pass, type: sum, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: right
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: take, id: sql 전문가 -
              take, name: sql 전문가 - take}, {axisId: pass, id: sql 전문가 - pass, name: sql
              전문가 - pass}, {axisId: take, id: 리눅스마스터 1급 - take, name: 리눅스마스터 1급 -
              take}, {axisId: pass, id: 리눅스마스터 1급 - pass, name: 리눅스마스터 1급 - pass},
          {axisId: take, id: 데이터분석 전문가 - take, name: 데이터분석 전문가 - take}, {axisId: pass,
            id: 데이터분석 전문가 - pass, name: 데이터분석 전문가 - pass}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    hidden_series: []
    series_types: {}
    x_axis_datetime_label: ''
    reference_lines: []
    show_dropoff: false
    show_null_points: false
    interpolation: linear
    cluster_points: false
    quadrants_enabled: false
    quadrant_properties:
      '0':
        color: ''
        label: Quadrant 1
      '1':
        color: ''
        label: Quadrant 2
      '2':
        color: ''
        label: Quadrant 3
      '3':
        color: ''
        label: Quadrant 4
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: ''
    custom_y_column: ''
    custom_value_label_column: ''
    defaults_version: 1
    hidden_pivots: {}
    value_labels: legend
    label_type: labPer
    up_color: false
    down_color: false
    total_color: false
    listen: {}
    row: 81
    col: 0
    width: 16
    height: 9
  - title: 하위 자격증 응시자/합격자 수
    name: 하위 자격증 응시자/합격자 수
    model: job-posting-dashboard
    explore: certification
    type: looker_column
    fields: [take, certification.test_year, certification.cert_name, pass]
    pivots: [certification.cert_name]
    filters:
      certification.cert_name: sql 개발자,데이터분석 준전문가,리눅스마스터 2급
    sorts: [certification.test_year, certification.cert_name desc, take desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: take, value_format: !!null '',
        value_format_name: !!null '', based_on: certification.take, _kind_hint: measure,
        measure: take, type: sum, _type_hint: number}, {category: measure, expression: !!null '',
        label: pass, value_format: !!null '', value_format_name: !!null '', based_on: certification.pass,
        _kind_hint: measure, measure: pass, type: sum, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: right
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: take, id: 데이터분석 준전문가
              - take, name: 데이터분석 준전문가 - take}, {axisId: pass, id: 데이터분석 준전문가 - pass,
            name: 데이터분석 준전문가 - pass}, {axisId: take, id: 리눅스마스터 2급 - take, name: 리눅스마스터
              2급 - take}, {axisId: pass, id: 리눅스마스터 2급 - pass, name: 리눅스마스터 2급 - pass},
          {axisId: take, id: sql 개발자 - take, name: sql 개발자 - take}, {axisId: pass,
            id: sql 개발자 - pass, name: sql 개발자 - pass}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    hidden_series: []
    series_types: {}
    reference_lines: []
    show_null_points: false
    interpolation: linear
    cluster_points: false
    quadrants_enabled: false
    quadrant_properties:
      '0':
        color: ''
        label: Quadrant 1
      '1':
        color: ''
        label: Quadrant 2
      '2':
        color: ''
        label: Quadrant 3
      '3':
        color: ''
        label: Quadrant 4
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: ''
    custom_y_column: ''
    custom_value_label_column: ''
    defaults_version: 1
    hidden_pivots: {}
    value_labels: legend
    label_type: labPer
    up_color: false
    down_color: false
    total_color: false
    listen: {}
    row: 72
    col: 0
    width: 16
    height: 9
  - name: " (7)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 86
    col: 16
    width: 8
    height: 4
  - name: " (8)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 77
    col: 16
    width: 8
    height: 4
  - title: 상위 자격증 합격률
    name: 상위 자격증 합격률
    model: job-posting-dashboard
    explore: certification
    type: looker_column
    fields: [certification.cert_name, certification.test_year, ratio]
    pivots: [certification.cert_name]
    filters:
      certification.cert_name: sql 전문가,데이터분석 전문가,리눅스마스터 1급
    sorts: [certification.cert_name desc, certification.test_year]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: min, value_format: !!null '',
        value_format_name: !!null '', based_on: certification.pass_ratio, _kind_hint: measure,
        measure: min, type: min, _type_hint: number}, {category: measure, expression: !!null '',
        label: max, value_format: !!null '', value_format_name: !!null '', based_on: certification.pass_ratio,
        _kind_hint: measure, measure: max, type: max, _type_hint: number}, {category: measure,
        expression: !!null '', label: avg, value_format: !!null '', value_format_name: !!null '',
        based_on: certification.pass_ratio, _kind_hint: measure, measure: avg, type: average,
        _type_hint: number}, {category: measure, expression: !!null '', label: ratio,
        value_format: !!null '', value_format_name: !!null '', based_on: certification.pass_ratio,
        _kind_hint: measure, measure: ratio, type: sum, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: min, id: min, name: min},
          {axisId: avg, id: avg, name: avg}, {axisId: max, id: max, name: max}], showLabels: false,
        showValues: true, maxValue: 100, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 42, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    hidden_series: []
    hide_legend: false
    series_types: {}
    reference_lines: []
    defaults_version: 1
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map: usa
    map_projection: ''
    value_labels: legend
    label_type: labPer
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    row: 81
    col: 16
    width: 8
    height: 5
  - title: 하위 자격증 합격률
    name: 하위 자격증 합격률
    model: job-posting-dashboard
    explore: certification
    type: looker_column
    fields: [certification.cert_name, certification.test_year, ratio]
    pivots: [certification.cert_name]
    filters:
      certification.cert_name: sql 개발자,데이터분석 준전문가,리눅스마스터 2급
    sorts: [certification.cert_name desc, certification.test_year]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: min, value_format: !!null '',
        value_format_name: !!null '', based_on: certification.pass_ratio, _kind_hint: measure,
        measure: min, type: min, _type_hint: number}, {category: measure, expression: !!null '',
        label: max, value_format: !!null '', value_format_name: !!null '', based_on: certification.pass_ratio,
        _kind_hint: measure, measure: max, type: max, _type_hint: number}, {category: measure,
        expression: !!null '', label: avg, value_format: !!null '', value_format_name: !!null '',
        based_on: certification.pass_ratio, _kind_hint: measure, measure: avg, type: average,
        _type_hint: number}, {category: measure, expression: !!null '', label: ratio,
        value_format: !!null '', value_format_name: !!null '', based_on: certification.pass_ratio,
        _kind_hint: measure, measure: ratio, type: sum, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: min, id: min, name: min},
          {axisId: avg, id: avg, name: avg}, {axisId: max, id: max, name: max}], showLabels: false,
        showValues: true, maxValue: 100, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 42, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    hidden_series: []
    hide_legend: false
    series_types: {}
    reference_lines: []
    defaults_version: 1
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map: usa
    map_projection: ''
    value_labels: legend
    label_type: labPer
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    row: 72
    col: 16
    width: 8
    height: 5
  - title: Untitled
    name: Untitled (2)
    model: job-posting-dashboard
    explore: recruit
    type: looker_grid
    fields: [recruit.tag, recruit.count_tmp]
    filters:
      recruit.tag: 데이터%
    sorts: [recruit.tag desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      recruit.tag: 분류
      recruit.count_tmp: 공고수
    series_column_widths:
      recruit.count_tmp: 80
    series_cell_visualizations:
      recruit.count_tmp:
        is_active: false
    series_types: {}
    defaults_version: 1
    title_hidden: true
    row: 10
    col: 20
    width: 4
    height: 7
  - title: 전체기간 평균검색량 비율
    name: 전체기간 평균검색량 비율
    model: job-posting-dashboard
    explore: google_trend
    type: looker_pie
    fields: [google_trend.kw, avg]
    filters:
      google_trend.kw: 빅데이터,인공지능,정보처리,백준
    sorts: [google_trend.kw desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: count, value_format: !!null '',
        value_format_name: !!null '', based_on: google_trend.count_google_trend, _kind_hint: measure,
        measure: count, type: sum, _type_hint: number}, {category: measure, expression: !!null '',
        label: avg, value_format: !!null '', value_format_name: !!null '', based_on: google_trend.count_google_trend,
        _kind_hint: measure, measure: avg, type: average, _type_hint: number}]
    value_labels: labels
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: count, id: 정보처리 - count,
            name: 정보처리}, {axisId: count, id: 인공지능 - count, name: 인공지능}, {axisId: count,
            id: 빅데이터 - count, name: 빅데이터}, {axisId: count, id: 백준 - count, name: 백준}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    swap_axes: false
    hidden_pivots: {}
    defaults_version: 1
    row: 92
    col: 18
    width: 6
    height: 8
  - title: Untitled
    name: Untitled (3)
    model: job-posting-dashboard
    explore: google_trend
    type: looker_line
    fields: [google_trend.date_week, google_trend.kw, count]
    pivots: [google_trend.kw]
    fill_fields: [google_trend.date_week]
    filters:
      google_trend.kw: 빅데이터,인공지능,정보처리,백준
    sorts: [google_trend.date_week, google_trend.kw desc]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: count, value_format: !!null '',
        value_format_name: !!null '', based_on: google_trend.count_google_trend, _kind_hint: measure,
        measure: count, type: sum, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: count, id: 정보처리 - count,
            name: 정보처리}, {axisId: count, id: 인공지능 - count, name: 인공지능}, {axisId: count,
            id: 빅데이터 - count, name: 빅데이터}, {axisId: count, id: 백준 - count, name: 백준}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: false
    series_types: {}
    swap_axes: false
    hidden_pivots: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    title_hidden: true
    row: 92
    col: 0
    width: 18
    height: 8
