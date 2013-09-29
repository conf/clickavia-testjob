class FlightsController < ApplicationController
  PAGE_SIZE = 10
  SORTABLE_FIELDS = ["depart_date", "depart_time", "arrive_time", "seats_status"]

  def index
    respond_to do |format|
      format.html
      format.json do
        offset = params[:iDisplayStart].to_i || PAGE_SIZE
        limit = params[:iDisplayLength].to_i || 0

        initialize_fields(params)
        filters = get_search_filters
        order_by = get_order_by_clauses

        @flights = Flight.limit(limit).offset(offset)

        filters.each do |field, value|
          @flights = field.include?('=') ? @flights.where(field, value) : @flights.where(field => value)
        end

        order_by.reverse.each do |field, value|
          @flights = @flights.order("#{field} #{value}")
        end

        data = @flights.includes(:depart_airport, :arrive_airport).map do |flight|
          flight.attributes.merge({
            depart_airport: flight.depart_airport.iata,
            arrive_airport: flight.arrive_airport.iata,
            depart_date: l(flight.depart_date, format: "%d %B %Yг."),
            depart_time: l(flight.depart_time, format: "%H:%M"),
            arrive_time: l(flight.arrive_time, format: "%H:%M"),
          })
        end
        total_records = Flight.count
        total_display_records = @flights.except(:limit, :offset).count
        render json: {
          sEcho: params[:sEcho].to_i,
          iTotalRecords: total_records,
          iTotalDisplayRecords: total_display_records,
          aaData: data
        }
      end
    end
  end

  private
  def initialize_fields(params)
    @params = params
    fields = get_fields_by_prefix('mDataProp_')
    @field_names = Hash[(0...fields.length).zip fields]
  end

  def get_fields_by_prefix(prefix, with_names = false)
    names = @params.keys.select { |key| key.to_s.start_with? prefix }.sort
    with_names ? names.zip(@params.values_at(*names)) : @params.values_at(*names)
  end

  def get_order_by_clauses
    name_indices = get_fields_by_prefix('iSortCol_').map(&:to_i)
    names = @field_names.values_at(*name_indices) & SORTABLE_FIELDS

    directions = get_fields_by_prefix('sSortDir_')

    names.length == directions.length ? names.zip(directions) : []
  end

  def get_search_filters
    search_filters = @field_names.values.zip get_fields_by_prefix('sSearch_')
    search_filters = add_custom_depart_date_filter(search_filters)

    filter_empty_values search_filters
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
    end

    search_filters
  end

  def filter_empty_values (values)
    values.select { |code, value| value.present?}
  end

end