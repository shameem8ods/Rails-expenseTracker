require "rails_helper"

RSpec.describe SavingsController do
    describe "GET index" do
        it "has a 200 status code" do
          get :new
          expect(response.status).to eq(302)
        end
      end
end