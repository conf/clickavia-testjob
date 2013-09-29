class DataTableAdapter

  def initialize(params)
    @params = params
    fields = get_fields_by_prefix('mDataProp_')
    @field_names = Hash[(0...fields.length).zip fields]
  end

  def get_fields_by_prefix(prefix, with_names = false)
    names = @params.keys.select { |key| key.to_s.start_with? prefix }.sort
    with_names ? names.zip(@params.values_at(*names)) : @params.values_at(*names)
  end

  def get_order_by(sortable_fields)
    name_indices = get_fields_by_prefix('iSortCol_').map(&:to_i)
    names = @field_names.values_at(*name_indices) & sortable_fields

    directions = get_fields_by_prefix('sSortDir_')

    names.length == directions.length ? names.zip(directions) : []
  end

  def get_filters
    search_filters = @field_names.values.zip get_fields_by_prefix('sSearch_')
    search_filters = add_custom_depart_date_filter(search_filters)

    filter_empty_values search_filters
  end

  def offset
    @params[:iDisplayStart].to_i || 0
  end

  def limit(page_size)
    @params[:iDisplayLength].to_i || page_size
  end

  def add_custom_depart_date_filter(search_filters)
    filters = get_fields_by_prefix('depart_date_', true)
    filters = filter_empty_values filters

    case filters.length
      when 2
        search_filters << ['depart_date >= :start_date AND depart_date <= :end_date ', {start_date: filters[0][1], end_date: filters[1][1]}]
      when 1
        depart_date_clause = (filters[0][0] == 'depart_date_from') ? 'depart_date >= ?' : 'depart_date <= ?'
        search_filters << [depart_date_clause, filters[0][1]]
      else
        search_filters
    end
  end

  def get_json(collection, data)
    total_records = collection.new.class.count
    total_display_records = collection.except(:limit, :offset).count
    {
        json: {
          sEcho: @params[:sEcho].to_i,
          iTotalRecords: total_records,
          iTotalDisplayRecords: total_display_records,
          aaData: data
        }
    }
  end

  def filter_empty_values (values)
    values.select { |code, value| value.present?}
  end
end