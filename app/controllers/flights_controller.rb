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
          @flights = @flights.where(field => value)
        end

        order_by.reverse.each do |field, value|
          @flights = @flights.order("#{field} #{value}")
        end

        data = @flights.includes(:depart_airport, :arrive_airport).map do |flight|
          flight.attributes.merge({
            depart_airport: flight.depart_airport.iata,
            arrive_airport: flight.arrive_airport.iata
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

  def get_fields_by_prefix(prefix)
    names = @params.keys.select { |key| key.to_s.start_with? prefix }.sort
    @params.values_at(*names)
  end

  def get_order_by_clauses
    name_indices = get_fields_by_prefix('iSortCol_').map(&:to_i)
    names = @field_names.values_at(*name_indices) & SORTABLE_FIELDS

    directions = get_fields_by_prefix('sSortDir_')

    if names.length == directions.length
      names.zip directions
    else
      []
    end
  end

  def get_search_filters
    search_filters = @field_names.values.zip get_fields_by_prefix('sSearch_')
    # filter empty values
    search_filters.reject { |code, value| value.empty?}
  end

end