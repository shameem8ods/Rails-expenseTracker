require "rails_helper"

RSpec.describe SavingsController do
   
        it "returns a success response" do
          get :new
          expect response.success?
        end

        it "returns a success response" do
          post :create
          expect response.success?
        end
    
 
end