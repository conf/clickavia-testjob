class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :title
      t.string :alpha2, limit: 2
      t.string :alpha3, limit: 3

      t.timestamps
    end
    add_index :countries, :alpha2
    add_index :countries, :alpha3
  end
end
