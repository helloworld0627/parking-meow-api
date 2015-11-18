class CreateParkingBusinessHours < ActiveRecord::Migration
  def change
    create_table :parking_business_hours do |t|

      t.timestamps null: false
    end
  end
end
