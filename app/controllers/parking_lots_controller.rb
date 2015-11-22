class ParkingLotsController < ApplicationController
  before_action :set_parking_lot, only: [:show, :update, :destroy]

  # GET /parking_lots
  # GET /parking_lots.json
  def index
    @parking_lots = ParkingLot.all

    render json: @parking_lots
  end

  # GET /parking_lots/1
  # GET /parking_lots/1.json
  def show
    render json: @parking_lot
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
