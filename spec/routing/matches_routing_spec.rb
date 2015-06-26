require "rails_helper"

RSpec.describe MatchesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/matches").to route_to("matches#index")
    end

    it "routes to #new" do
      expect(:get => "/matches/new").to route_to("matches#new")
    end

    it "routes to #create" do
      expect(:post => "/matches").to route_to("matches#create")
    end

  end
end
