class ParkingRate < ActiveRecord::Base
	enum rate_type: [ :rte_1hr, :rte_2hr, :rte_3hr, :rte_allday ]
end
