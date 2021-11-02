require "rails_helper"

RSpec.describe SavingsController, type: :routing do

  describe "routing" do
    it "routes to #index" do
      expect(get: "/savings").to route_to("savings#index")
    end
  end

  it "routes to #new" do
    expect(get: "/savings/new").to route_to("savings#new")
  end



  it "routes to #edit" do
    expect(get: "/savings/1/edit").to route_to("savings#edit", id: "1")
  end

  it "routes to #create" do
    expect(post: "/savings").to route_to("savings#create")
  end

    it "routes to #update via PUT" do
    expect(put: "/savings/1").to route_to("savings#update", id: "1")
  end

  it "routes to #update via PATCH" do
    expect(patch: "/savings/1").to route_to("savings#update", id: "1")
  end

  it "routes to #destroy" do
    expect(delete: "/savings/1").to route_to("savings#destroy", id: "1")
  end

end