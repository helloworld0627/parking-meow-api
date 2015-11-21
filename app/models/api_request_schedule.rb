class ApiRequestSchedule < ActiveRecord::Base
	enum status: [ :prepare, :run, :succeed, :fail ]

	@@api_path = 'https://data.seattle.gov/resource/3neb-8edu.json'

	def self.etl
		apiRequestSchedule = ApiRequestSchedule.create ({
			"request_url" => @@api_path,
			"status" => :prepare
		})

		response = RestClient.get(@@api_path) { |response, request, result, &block|
			case response.code
			when 200
				# set status to run
				current_status = :run
				apiRequestSchedule.status = current_status
				apiRequestSchedule.save!

				# parse json response to parking lots
				parsed_json = ActiveSupport::JSON.decode response
				parkingLots = parse_JSON_to_Obj parsed_json
				# save
				insert_parkingLots apiRequestSchedule, parkingLots
			when 423
				apiRequestSchedule.status = :fail
				apiRequestSchedule.save!
				raise SomeCustomExceptionIfYouWant
			else
				apiRequestSchedule.status = :fail
				apiRequestSchedule.save!
				response.return!(request, result, &block)
			end
		}

		# return 
		apiRequestSchedule
	end

	def self.insert_parkingLots(apiRequestSchedule, parkingLots)
		apiRequestSchedule.status = :run
		apiRequestSchedule.save!

		apiRequestSchedule.transaction do
			parkingLots.each do |p|
				p.save!
			end
			apiRequestSchedule.status = :succeed
		end

		apiRequestSchedule.save!
	end

	def self.parse_JSON_to_Obj(parsed_json)
		other_type_lookup = { 
			"N" => "other_no",
			"Y" => "other_yes"
		}
		payment_type_lookup = {
			"Cash" => "payment_cash"
		}
		outofserv_type_lookup = {
			"N" => "outofserv_no",
			"Y" => "outofserv_yes"
		}

		results = []
		parsed_json.each do |item|
			# parse parking lot
			parkingLot = ParkingLot.new do |p|
				# item keys are json attribute name
				p.objectid = item["objectid"]
				p.buslic_location_id = item["buslic_location_id"]
				p.dea_facility_address = item["dea_facility_address"]
      			p.dea_stalls = item["dea_stalls"]
      			p.fac_name = item["fac_name"]
      			p.disabled = item["disabled"]
      			p.op_name = item["op_name"]
     			p.op_phone = item["op_phone"]
     			p.op_phone2 = item["op_phone2"]
    		    p.op_web = item["op_web"]
  			    p.payment_type = payment_type_lookup[item["payment_type"]]
 	   		    p.other_type = other_type_lookup[item["other"]]
			    p.webname = item["webname"]
 		        p.regionid = item["regionid"]
 		        p.outofserv_type = outofserv_type_lookup[item["outofserv"]]
    		    p.vacant = item["vacant"]
		        p.signid = item["signid"]
		        #shape
		        shape = item["shape"]
  		        p.longtitude= shape["longitude"]
   		        p.latitude = shape["latitude"]
   		        # puts p.to_json
			end

			# enum rate_type are json attribute name
			ParkingRate.rate_types.each do |k,v|
				# puts k
				if item.key? k
					rate = parkingLot.parkingRates.new do |r|
						r.rate_type = k
						r.price = item[k]
						# puts r.to_json
					end
				end
			end

			# enum hour_type are json attribute name
			ParkingBusinessHour.hour_types.each do |k,v|
				# puts k
				if item.key? k
					biz_hour = parkingLot.parkingBusinessHours.new do |b|
						b.hour_type = k
						b.from_to = item[k]
						# puts b.to_json
					end
				end
			end

			results.append parkingLot
		end

		# return results
		results
	end
end
