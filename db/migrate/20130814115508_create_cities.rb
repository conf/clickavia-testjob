class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :country, index: true
      t.string :title
      t.string :iata, limit: 3

      t.timestamps
    end
    add_index :cities, :iata
  end
end
