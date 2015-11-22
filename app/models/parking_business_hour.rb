class ParkingBusinessHour < ActiveRecord::Base
	belongs_to :parkingLot
	enum hour_type: [ :hrs_monfri, :hrs_sat, :hrs_sun ]
end
