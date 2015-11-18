class CreateParkingRates < ActiveRecord::Migration
  def change
    create_table :parking_rates do |t|

      t.column :rate_type, :integer, default: 0 # 1hr, 2hr ,3hr, all_day
      t.decimal :price
      t.string :description

      t.timestamps null: false
    end
  end
end
