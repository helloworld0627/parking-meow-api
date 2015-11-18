class CreateParkingRates < ActiveRecord::Migration
  def change
    create_table :parking_rates do |t|

      t.timestamps null: false
    end
  end
end
