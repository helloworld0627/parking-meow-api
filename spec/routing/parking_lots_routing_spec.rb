require "rails_helper"

RSpec.describe ParkingLotsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/parking_lots").to route_to("parking_lots#index")
    end

    it "routes to #new" do
      expect(:get => "/parking_lots/new").to route_to("parking_lots#new")
    end

    it "routes to #show" do
      expect(:get => "/parking_lots/1").to route_to("parking_lots#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/parking_lots/1/edit").to route_to("parking_lots#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/parking_lots").to route_to("parking_lots#create")
    end

    it "routes to #update" do
      expect(:put => "/parking_lots/1").to route_to("parking_lots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/parking_lots/1").to route_to("parking_lots#destroy", :id => "1")
    end

  end
end
