class CreateParkingLots < ActiveRecord::Migration
  def change
    create_table :parking_lots do |t|

      t.integer :objectid
      t.integer :buslic_location_id
      t.string :dea_facility_address
      t.integer :dea_stalls
      t.string :fac_name
      t.integer :disabled
      t.string :op_name
      t.string :op_phone
      t.string :op_phone2
      t.string :op_web
      t.column :payment_type, :integer, default: 0
      t.column :other, :integer, default: 0 # Y/N text
      t.string :webname
      t.integer :regionid
      t.column :outofserv, :integer, default: 0 #Y/N text
      t.integer :vacant
      t.string :signid
      t.decimal :longtitude, :precision => 15, :scale => 13
      t.decimal :latitude, :precision => 15, :scale => 13
      
      t.timestamps null: false
    end
  end
end
