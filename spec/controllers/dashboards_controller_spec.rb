require "rails_helper"

RSpec.describe DashboardsController do
        it "returns a success response" do
          get :index
          expect response.success?
        end
end