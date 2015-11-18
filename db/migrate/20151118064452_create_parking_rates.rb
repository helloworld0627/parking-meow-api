class CreateParkingRates < ActiveRecord::Migration
  def change
    create_table :parking_rates do |t|

      t.column :rate_type, :integer, default: 0 # 1hr, 2hr ,3hr, all_day
      t.decimal :price
      t.string :description

      t.references :parking_lot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
