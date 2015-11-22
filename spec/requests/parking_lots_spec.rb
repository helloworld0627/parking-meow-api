require 'rails_helper'

RSpec.describe "ParkingLots", :type => :request do
  describe "GET /parking_lots" do
    it "works! (now write some real specs)" do
      get parking_lots_path
      expect(response.status).to be(200)
    end
  end
end
