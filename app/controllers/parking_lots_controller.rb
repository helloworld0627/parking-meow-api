class ParkingLotsController < ApplicationController
  before_action :set_parking_lot, only: [:show, :update, :destroy]

  # GET /parking_lots
  # GET /parking_lots.json
  def index

    @parking_lots = ParkingLot.all
    # rate query
    rate_query = rate_query()
    puts rate_query
    @parking_lots = @parking_lots.joins(:parkingRates).where(rate_query) unless rate_query.empty?
    # hour query
    hour_query = hour_query()
    puts hour_query
    @parking_lots = @parking_lots.joins(:parkingBusinessHours).where(hour_query) unless hour_query.empty?

    # filter by lat long
    @parking_lots = @parking_lots.distinct(:id)
    if params.key? "longtitude" and params.key? "latitude"
      ids = []
      @parking_lots.each do |p|
        longtitude_val = BigDecimal.new(params["longtitude"])
        latitude_val = BigDecimal.new(params["latitude"])
        loc1 = [latitude_val, longtitude_val]
        loc2 = [p.latitude, p.longtitude]
        d = distance loc1, loc2
        if d <= 1
          ids.append(p.id)
        end
      end
      @parking_lots = @parking_lots.find(ids)
    end

    response = @parking_lots.as_json(include: [:parkingRates, :parkingBusinessHours])
    render json: response
  end

  # GET /parking_lots/1
  # GET /parking_lots/1.json
  def show
    response = @parking_lot.as_json(include: [:parkingRates, :parkingBusinessHours])
    render json: response
  end

  # POST /parking_lots
  # POST /parking_lots.json
  def create
    @parking_lot = ParkingLot.new(parking_lot_params)

    if @parking_lot.save
      render json: @parking_lot, status: :created, location: @parking_lot
    else
      render json: @parking_lot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parking_lots/1
  # PATCH/PUT /parking_lots/1.json
  def update
    @parking_lot = ParkingLot.find(params[:id])

    if @parking_lot.update(parking_lot_params)
      head :no_content
    else
      render json: @parking_lot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /parking_lots/1
  # DELETE /parking_lots/1.json
  def destroy
    @parking_lot.destroy

    head :no_content
  end

  private

    def set_parking_lot
      @parking_lot = ParkingLot.find(params[:id])
    end

    def parking_lot_params
      params[:parking_lot]
    end

    def rate_query
      # query with parameter 'rates'
      rate_criteria = []
      ParkingRate.rate_types.each do |type_name, type_val|
        if params.key? type_name
          stmt = "(rate_type=#{type_val} and price <= #{params[type_name]})"
          rate_criteria.append stmt
        end
      end
      rate_criteria.join "and"
    end

    def hour_query
      # query business hour is opened
      hour_criteria = []
      ParkingBusinessHour.hour_types.each do |type_name, type_val|
        if params.key? type_name
          from_to_val = (params[type_name].eql? 'true') ? "NOTNULL" : "ISNULL"
          stmt = "(hour_type = #{type_val} and from_to #{from_to_val})"
          hour_criteria.append stmt
        end
      end
      hour_criteria.join "and"
    end

    def distance loc1, loc2
      rad_per_deg = Math::PI/180  # PI / 180
      rkm = 6371                  # Earth radius in kilometers
      rmile = rkm / 1.6             # Radius in miles
      dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
      dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

      lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
      lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
      a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      rmile * c # Delta in miles
    end
end
