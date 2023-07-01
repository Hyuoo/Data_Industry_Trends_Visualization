- dashboard: search_recruit
  title: search_recruit
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 9fILWjlU2dwgDtAvXm0Fo6
  elements:
  - title: ''
    name: ''
    model: job-posting-dashboard
    explore: recruit
    type: looker_grid
    fields: [recruit.posting_date, recruit.title, recruit.industry_category, recruit.industry,
      recruit.exp_name, recruit.exp_min, recruit.wide_location, recruit.location_name,
      recruit.read_cnt, recruit.apply_cnt]
    sorts: [recruit.posting_date desc]
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
    pinned_columns:
      "$$$_row_numbers_$$$": left
    column_order: ["$$$_row_numbers_$$$", recruit.posting_date, recruit.title, recruit.industry_category,
      recruit.industry, recruit.exp_name, recruit.exp_min, recruit.wide_location,
      recruit.location_name, recruit.read_cnt, recruit.apply_cnt]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      recruit.posting_date: 등록일
      recruit.title: 제목
      recruit.industry_category: 산업분류
      recruit.industry: 산업상세
      recruit.exp_name: 경력요건
      recruit.exp_min: 최소경력
      recruit.wide_location: 지역구분
      recruit.location_name: 지역상세
      recruit.read_cnt: 조회수
      recruit.apply_cnt: 신청수
    series_column_widths:
      recruit.title: 185
      recruit.posting_date: 89
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
    defaults_version: 1
    series_types: {}
    truncate_column_names: false
    title_hidden: true
    listen:
      지역상세: recruit.location_name
      경력요건: recruit.exp_name
      직종: recruit.tag
    row: 2
    col: 0
    width: 18
    height: 11
  - title: 지역상세 상위 8
    name: 지역상세 상위 8
    model: job-posting-dashboard
    explore: recruit
    type: looker_bar
    fields: [recruit.location_name, recruit.count_tmp]
    sorts: [recruit.count_tmp desc 0]
    limit: 8
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: recruit.count_tmp,
            id: recruit.count_tmp, name: Count Tmp}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: false
    series_types: {}
    hidden_pivots: {}
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    show_null_points: true
    interpolation: linear
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 0
    col: 18
    width: 4
    height: 5
  - title: 직종 별 비율
    name: 직종 별 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_bar
    fields: [recruit.count_tmp, recruit.tag]
    pivots: [recruit.tag]
    filters: {}
    sorts: [recruit.tag desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: 프론트엔드 - recruit.count_tmp,
            id: 프론트엔드 - recruit.count_tmp, name: 프론트엔드}, {axisId: 임베디드 - recruit.count_tmp,
            id: 임베디드 - recruit.count_tmp, name: 임베디드}, {axisId: 보안 - recruit.count_tmp,
            id: 보안 - recruit.count_tmp, name: 보안}, {axisId: 백엔드 - recruit.count_tmp,
            id: 백엔드 - recruit.count_tmp, name: 백엔드}, {axisId: 데이터엔지니어 - recruit.count_tmp,
            id: 데이터엔지니어 - recruit.count_tmp, name: 데이터엔지니어}, {axisId: 데이터사이언티스트 -
              recruit.count_tmp, id: 데이터사이언티스트 - recruit.count_tmp, name: 데이터사이언티스트},
          {axisId: 데이터분석가 - recruit.count_tmp, id: 데이터분석가 - recruit.count_tmp, name: 데이터분석가}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    hide_legend: true
    font_size: '12'
    series_types: {}
    value_labels: legend
    label_type: labPer
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 0
    col: 5
    width: 6
    height: 2
  - title: 지역구분 비율
    name: 지역구분 비율
    model: job-posting-dashboard
    explore: recruit
    type: looker_bar
    fields: [recruit.count_tmp, recruit.wide_location]
    pivots: [recruit.wide_location]
    sorts: [recruit.wide_location desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: simplifica
      palette_id: simplifica-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: 충북전체 - recruit.count_tmp,
            id: 충북전체 - recruit.count_tmp, name: 충북전체}, {axisId: 충남전체 - recruit.count_tmp,
            id: 충남전체 - recruit.count_tmp, name: 충남전체}, {axisId: 제주전체 - recruit.count_tmp,
            id: 제주전체 - recruit.count_tmp, name: 제주전체}, {axisId: 전북전체 - recruit.count_tmp,
            id: 전북전체 - recruit.count_tmp, name: 전북전체}, {axisId: 전남전체 - recruit.count_tmp,
            id: 전남전체 - recruit.count_tmp, name: 전남전체}, {axisId: 전국 - recruit.count_tmp,
            id: 전국 - recruit.count_tmp, name: 전국}, {axisId: 인천전체 - recruit.count_tmp,
            id: 인천전체 - recruit.count_tmp, name: 인천전체}, {axisId: 유럽전체 - recruit.count_tmp,
            id: 유럽전체 - recruit.count_tmp, name: 유럽전체}, {axisId: 울산전체 - recruit.count_tmp,
            id: 울산전체 - recruit.count_tmp, name: 울산전체}, {axisId: 아프리카전체 - recruit.count_tmp,
            id: 아프리카전체 - recruit.count_tmp, name: 아프리카전체}, {axisId: 아시아·중동전체 - recruit.count_tmp,
            id: 아시아·중동전체 - recruit.count_tmp, name: 아시아·중동전체}, {axisId: 세종특별자치시 -
              recruit.count_tmp, id: 세종특별자치시 - recruit.count_tmp, name: 세종특별자치시},
          {axisId: 서울전체 - recruit.count_tmp, id: 서울전체 - recruit.count_tmp, name: 서울전체},
          {axisId: 북·중미전체 - recruit.count_tmp, id: 북·중미전체 - recruit.count_tmp, name: 북·중미전체},
          {axisId: 부산전체 - recruit.count_tmp, id: 부산전체 - recruit.count_tmp, name: 부산전체},
          {axisId: 대전전체 - recruit.count_tmp, id: 대전전체 - recruit.count_tmp, name: 대전전체},
          {axisId: 대구전체 - recruit.count_tmp, id: 대구전체 - recruit.count_tmp, name: 대구전체},
          {axisId: 남미전체 - recruit.count_tmp, id: 남미전체 - recruit.count_tmp, name: 남미전체},
          {axisId: 기타해외 - recruit.count_tmp, id: 기타해외 - recruit.count_tmp, name: 기타해외},
          {axisId: 광주전체 - recruit.count_tmp, id: 광주전체 - recruit.count_tmp, name: 광주전체},
          {axisId: 경북전체 - recruit.count_tmp, id: 경북전체 - recruit.count_tmp, name: 경북전체},
          {axisId: 경남전체 - recruit.count_tmp, id: 경남전체 - recruit.count_tmp, name: 경남전체},
          {axisId: 경기전체 - recruit.count_tmp, id: 경기전체 - recruit.count_tmp, name: 경기전체},
          {axisId: 강원전체 - recruit.count_tmp, id: 강원전체 - recruit.count_tmp, name: 강원전체}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: true
    series_types: {}
    value_labels: none
    label_type: labPer
    defaults_version: 1
    hidden_pivots: {}
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 0
    col: 11
    width: 7
    height: 2
  - title: Untitled
    name: Untitled
    model: job-posting-dashboard
    explore: recruit
    type: single_value
    fields: [recruit.count_tmp]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 공고 수
    series_types: {}
    defaults_version: 1
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 0
    col: 0
    width: 3
    height: 2
  - title: Untitled
    name: Untitled (2)
    model: job-posting-dashboard
    explore: recruit
    type: looker_column
    fields: [recruit.count_tmp, recruit.exp_name]
    pivots: [recruit.exp_name]
    sorts: [recruit.exp_name]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: recruit.count_tmp, id: 경력
              - recruit.count_tmp, name: 경력}, {axisId: recruit.count_tmp, id: 경력무관
              - recruit.count_tmp, name: 경력무관}, {axisId: recruit.count_tmp, id: 신입
              - recruit.count_tmp, name: 신입}, {axisId: recruit.count_tmp, id: 신입/경력
              - recruit.count_tmp, name: 신입/경력}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: false
    y_axis_zoom: false
    series_types: {}
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    value_labels: legend
    label_type: labPer
    title_hidden: true
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 0
    col: 22
    width: 2
    height: 5
  - title: 최다 지원수 공고
    name: 최다 지원수 공고
    model: job-posting-dashboard
    explore: recruit
    type: looker_grid
    fields: [recruit.title, recruit.read_cnt, recruit.apply_cnt]
    sorts: [recruit.apply_cnt desc]
    limit: 5
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
    minimum_column_width: 30
    series_labels:
      recruit.read_cnt: Read
      recruit.apply_cnt: Apply
    series_column_widths:
      recruit.read_cnt: 70
      recruit.apply_cnt: 70
    series_cell_visualizations:
      recruit.read_cnt:
        is_active: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types: {}
    defaults_version: 1
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 9
    col: 18
    width: 6
    height: 4
  - title: 최다 조회수 공고
    name: 최다 조회수 공고
    model: job-posting-dashboard
    explore: recruit
    type: looker_grid
    fields: [recruit.title, recruit.read_cnt, recruit.apply_cnt]
    sorts: [recruit.read_cnt desc]
    limit: 5
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
    minimum_column_width: 30
    series_labels:
      recruit.read_cnt: Read
      recruit.apply_cnt: Apply
    series_column_widths:
      recruit.read_cnt: 70
      recruit.apply_cnt: 70
    series_cell_visualizations:
      recruit.read_cnt:
        is_active: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types: {}
    defaults_version: 1
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 5
    col: 18
    width: 6
    height: 4
  - title: Untitled
    name: Untitled (3)
    model: job-posting-dashboard
    explore: recruit
    type: single_value
    fields: [calculation]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: 경력평균, value_format: !!null '',
        value_format_name: !!null '', based_on: recruit.exp_min, _kind_hint: measure,
        measure: calculation, type: average, _type_hint: number, filters: {recruit.exp_min: not
            0}}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 평균경력
    value_format: "#.00"
    defaults_version: 1
    listen:
      직종: recruit.tag
      경력요건: recruit.exp_name
      지역구분: recruit.wide_location
      지역상세: recruit.location_name
    row: 0
    col: 3
    width: 2
    height: 2
  filters:
  - name: 직종
    title: 직종
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: job-posting-dashboard
    explore: recruit
    listens_to_filters: []
    field: recruit.tag
  - name: 경력요건
    title: 경력요건
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: job-posting-dashboard
    explore: recruit
    listens_to_filters: []
    field: recruit.exp_name
  - name: 지역구분
    title: 지역구분
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: job-posting-dashboard
    explore: recruit
    listens_to_filters: []
    field: recruit.wide_location
  - name: 지역상세
    title: 지역상세
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: job-posting-dashboard
    explore: recruit
    listens_to_filters: [지역구분, Wide Location]
    field: recruit.location_name
