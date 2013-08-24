class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.references :city, index: true
      t.string :title
      t.string :iata, limit: 3

      t.timestamps
    end
    add_index :airports, :iata
  end
end
