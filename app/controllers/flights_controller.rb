class FlightsController < ApplicationController
  PAGE_SIZE = 10
  def index
    respond_to do |format|
      format.html
      format.json do
        offset = params[:iDisplayStart].to_i || PAGE_SIZE
        limit = params[:iDisplayLength].to_i || 0

        @flights = Flight.limit(limit).offset(offset)

        fields = []
        filters = []
        params.each do |key, val|
          if key.to_s.start_with? 'mDataProp'
            position = key.split('_').last.to_i
            fields[position] = val
          end

          if key.to_s.start_with? 'sSearch'
            position = key.split('_').last.to_i
            filters[position] = val
          end
        end
        fields.zip(filters).select {|arr| arr.all?(&:present?) }.each do |filter|
          @flights = @flights.where(filter.first => filter.last)
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
end