class FlightsController < ApplicationController
  PAGE_SIZE = 10
  SORTABLE_FIELDS = ["depart_date", "depart_time", "arrive_time", "seats_status"]

  def index
    respond_to do |format|
      format.html
      format.json do
        dt_adapter = DataTableAdapter.new(params)

        @flights = Flight.limit(dt_adapter.limit(PAGE_SIZE)).offset(dt_adapter.offset)

        dt_adapter.get_filters.each do |field, value|
          @flights = field.include?('=') ? @flights.where(field, value) : @flights.where(field => value)
        end

        # reverse our order_by clauses since Rails applies them in reverse order
        dt_adapter.get_order_by(SORTABLE_FIELDS).reverse.each do |field, value|
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

        render dt_adapter.get_json(@flights, data)

      end
    end
  end
end