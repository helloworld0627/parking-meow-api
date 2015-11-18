class CreateParkingBusinessHours < ActiveRecord::Migration
  def change
    create_table :parking_business_hours do |t|

	  t.column :hour_type, :integer, default: 0 # monfri, sun, sat
      t.string :from_to

      t.references :parking_lot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
