require "rails_helper"

RSpec.describe NotebooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/notebooks").to route_to("notebooks#index")
    end

    it "routes to #new" do
      expect(:get => "/notebooks/new").to route_to("notebooks#new")
    end

    it "routes to #show" do
      expect(:get => "/notebooks/1").to route_to("notebooks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/notebooks/1/edit").to route_to("notebooks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/notebooks").to route_to("notebooks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/notebooks/1").to route_to("notebooks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/notebooks/1").to route_to("notebooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/notebooks/1").to route_to("notebooks#destroy", :id => "1")
    end

  end
end
