class ParkingLotsController < ApplicationController
  before_action :set_parking_lot, only: [:show, :update, :destroy]

  # GET /parking_lots
  # GET /parking_lots.json
  def index
    # query with parameter 'rates'
    rate_query = "false"
    ParkingRate.rate_types.each do |type_name, type_val|
      if params.key? type_name
        price = params[type_name]
        rate_query += " or (rate_type=#{type_val} and price <=#{price} and price > 0)"
      end
    end
    # puts rate_query
    # rate_result = ParkingRate.where(rate_query) unless rate_query.eql? "false"

    hour_query = "false"
    ParkingBusinessHour.hour_types.each do |type_name, type_val|
      if params.key? type_name
        hour_query += " or hour_type=#{type_val}"
      end
    end
    # puts hour_query
    # hour_result = ParkingBusinessHour.where(hour_query) unless hour_query.eql? "false"

    loc_query = nil
    if params.key? "longtitude" and params.key? "latitude"
      longtitude_val = params["longtitude"]
      latitude_val = params["latitude"]
      # TODO: fix search functionality
      #degree_per_mile_approx = 0.05 
      #loc_query = "Pow(longtitude - #{longtitude_val},2) + Pow(latitude - #{latitude_val},2) < #{degree_per_mile_approx}"
    end

    @parking_lots = ParkingLot.all
    @parking_lots = @parking_lots.joins(:parkingRates).where(rate_query) unless rate_query.eql? "false"
    @parking_lots = @parking_lots.joins(:parkingBusinessHours).where(hour_query) unless hour_query.eql? "false"
    @parking_lots = @parking_lots.where(loc_query) unless loc_query.nil?
    @parking_lots = @parking_lots.distinct(:id)

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
end
