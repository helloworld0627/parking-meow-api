class ParkingLot < ActiveRecord::Base
	has_many :parkingRates
	has_many :parkingBusinessHours

	enum payment_type: [ :payment_unknown, :payment_cash ]
	enum other_type: [ :other_no, :other_yes ]
	enum outofserv_type: [ :outofserv_no, :outofserv_yes ]
end
