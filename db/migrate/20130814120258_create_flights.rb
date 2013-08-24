class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :depart_airport_id
      t.integer :arrive_airport_id
      t.string :code, limit: 10
      t.date :depart_date
      t.time :depart_time
      t.time :arrive_time
      t.string :seats_status

      t.timestamps
    end
    add_index :flights, [:depart_airport_id, :arrive_airport_id, :depart_date], name: 'index_flights_on_airports_and_date'
  end
end
