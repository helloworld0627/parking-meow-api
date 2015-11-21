class ParkingBusinessHour < ActiveRecord::Base
	enum hour_type: [ :hrs_monfri, :hrs_sat, :hrs_sun ]
end
