require 'rails_helper'


RSpec.describe "Savings", type: :request do
  current_user = User.first_or_create!(email:'john@example.com',password:"password",password_confirmation:"password")
 
  let(:valid_attributes) do {
    'id' => '1',
    'saving_type' => 'test',
    'amount' => '5000',
    'user' => current_user

  }
end

  let(:invalid_attributes) do {
     'id' => 'a',
    'saving_type' => '1',
    'amount' => 'a'
  }
end
  describe "GET /index" do
    it 'should save successfully' do
      saving = Saving.new( valid_attributes).save
      expect(saving).to eq(true)
    end
  end
    
  describe "GET /new" do
    it "returns a success response" do
      saving = Saving.new(valid_attributes)
      saving.user = current_user
      saving.save
      get new_saving_url
      expect response.success?
    end
  end

  
  describe "GET /edit" do
    it "returns a success response" do
      saving = Saving.new(valid_attributes)
      saving.user = current_user
      saving.save
      get edit_saving_url(saving)
      expect response.success?
    end
  end


  describe "POST /create" do
        context "with valid parameters" do
          it "creates a new saving" do
            expect do
              saving = Saving.new(valid_attributes)
              saving.user = current_user
              saving.save
              post savings_url, params: { saving: valid_attributes }
          end.to change(Saving, :count).by(1)
        end
      end

      it "redirects to the login path" do
        post savings_url, params: { saving: valid_attributes }
        expect(response).to redirect_to(new_user_session_url)

    end

      it "does not create a new saving" do
        expect {
          post savings_url, params: { saving: invalid_attributes }
        }.to change(Saving, :count).by(0)
      end
      it "renders a successful response to display the new template" do
        post savings_url, params: { saving: invalid_attributes }
        expect response.success?
      end

end

describe 'PATCH /update' do
    let(:new_attributes) do
      {
        'id' => '2' ,      
        'saving_type' => 'refund',
        'amount' => '9000',
        'user' => current_user
      }
    end

    it 'updates the requested saving' do
     saving = Saving.new(valid_attributes)
     saving.user = current_user
     saving.save
      patch saving_url(saving), params: { saving: new_attributes }
      saving.reload
      expect response.success?
    end

    it "renders a successful response  to display the edit template" do
      saving = Saving.create! valid_attributes
      patch saving_url(saving), params: { saving: invalid_attributes }
      expect response.success?
    end
    it "redirects to the login path" do
      saving = Saving.create! valid_attributes
   patch saving_url(saving), params: { saving: new_attributes }
   saving.reload
   expect(response).to redirect_to(new_user_session_url)
 end
end

describe 'DELETE /destroy' do
    it 'destroys the requested saving' do
      saving = Saving.new(valid_attributes)
      saving.user = current_user
      saving.save
      expect do
        saving.delete
      end.to change(Saving, :count).by(-1)
    end

    it "redirects to the login path" do
      saving = Saving.create! valid_attributes
      delete saving_url(saving)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

end
