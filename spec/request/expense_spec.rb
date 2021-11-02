require 'rails_helper'

RSpec.describe "Expenses", type: :request do
    current_user = User.first_or_create!(email:'john@example.com',password:"password",password_confirmation:"password")
 
  let(:valid_attributes) do {
    'id' => '1',
    'expense_type' => 'test',
    'amount' => '5000',
    'user' => current_user

  }
end

  let(:invalid_attributes) do {
     'id' => 'a',
    'expense_type' => '1',
    'amount' => 'a'
  }
end
  describe "GET /new" do
    it "returns a success response" do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        get new_expense_url
        expect response.success?
      end
  end
  
  describe "GET /edit" do
      it "returns a success response" do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        get edit_expense_url(expense)
        expect response.success?
      end
  end


  describe "POST /create" do
      context "with valid parameters" do
        it "creates a new expense" do
          expect do
            expense = Expense.new(valid_attributes)
            expense.user = current_user
            expense.save
            post expenses_url, params: { expense: valid_attributes }
        end.to change(Expense, :count).by(1)
      end
    end
    it "does not create a new expense" do
      expect {
        post expenses_url, params: { expense: invalid_attributes }
      }.to change(Expense, :count).by(0)
      
    end

     it "redirects to the expense" do
        post expenses_url, params: { expense: valid_attributes }
        expect(response).to redirect_to(new_user_session_url)
    
    end
  end
  
  describe 'PATCH /update' do
      let(:new_attributes) do
        {
          'id' => '2' ,      
          'expense_type' => 'refund',
          'amount' => '9000',
          'user' => current_user
        }
      end
  
      it 'updates the requested expense' do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        patch expense_url(expense), params: { expense: new_attributes }
        expense.reload
        expect response.success?
      end
  
      it "renders a successful response  to display the edit template" do
        expense = Expense.create! valid_attributes
        patch expense_url(expense), params: { expense: invalid_attributes }
        expect response.success?
      end
      it "redirects to the login path" do
        expense = Expense.create! valid_attributes
     patch expense_url(expense), params: { expense: new_attributes }
     expense.reload
     expect(response).to redirect_to(new_user_session_url)
    end
  end
  
  
  describe 'DELETE /destroy' do
      it 'destroys the requested expense' do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        expect do
            expense.delete
        end.to change(Expense, :count).by(-1)
      end 

    it "redirects to the login path" do
        expense = Expense.create! valid_attributes
        delete expense_url(expense)
        expect(response).to redirect_to(new_user_session_url)
      end
  end


end
