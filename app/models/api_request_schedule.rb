class ApiRequestSchedule < ActiveRecord::Base
	enum status: [ :new, :run, :succeed, :fail ]

	@@api_path = 'https://data.seattle.gov/resource/3neb-8edu.json'

	def self.etl
		response = RestClient.get(@@api_path) { |response, request, result, &block|
			case response.code
			when 200
				parsed_json = ActiveSupport::JSON.decode response
				parse_JSON_to_Obj parsed_json
			when 423
				raise SomeCustomExceptionIfYouWant
			else
				response.return!(request, result, &block)
			end
		}
	end

	def self.parse_JSON_to_Obj(parsed_json)
		parsed_json.each do |item|
			parkingLot = ParkingLot.new do |p|
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
  			    #p.payment_type, :integer, default: 0
 	   		    #t.column :other, :integer, default: 0 # Y/N text
			    p.webname = item["webname"]
 		        p.regionid = item["regionid"]
 		        #t.column :outofserv, :integer, default: 0 #Y/N text
    		    p.vacant = item["vacant"]
		        p.signid = item["signid"]
		        shape = item["shape"]
  		        p.longtitude= shape["longitude"]
   		        p.latitude = shape["latitude"]
   		        #puts p.to_json
			end

			rte = 
		end
	end	
end
