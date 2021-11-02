require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
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

  it 'total savings' do
    saving = Saving.create(id:"1",saving_type:"salary",amount:"1000")
    saving.save
    expense = Expense.create(id:"1",expense_type:"rent",amount:"500")
    expense.save
    totalsavings =Saving.sum(:amount)-Expense.sum(:amount)
    expect totalsavings == "500"
  end

  it 'total expenses' do
    expense = Expense.create(id:"1",expense_type:"rent",amount:"500")
    expense.save
    totalexpenses =Expense.sum(:amount)
    expect totalexpenses == "500"
  end


context 'expense' do

   describe "GET /index" do
      it "renders the index template" do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        get root_url
        expect response.success?
      end
    end


    it "renders the new expense url from dashboard page" do
        get new_expense_url
        expect response.success?
      end

       it "renders the edit expense url from dashboard page" do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        get edit_expense_url(expense)
        expect response.success?
      end

      context "creates a expense with valid attributes" do
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
    it "redirects to the login" do
        post expenses_url, params: { expense: valid_attributes }
        expect(response).to redirect_to(new_user_session_url)
    
    end
  
  
  
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
      it "redirects to the login" do
        expense = Expense.create! valid_attributes
     patch expense_url(expense), params: { expense: new_attributes }
     expense.reload
     expect(response).to redirect_to(new_user_session_url)
  
   end
  
  
  
      it 'destroys the requested expense' do
        expense = Expense.new(valid_attributes)
        expense.user = current_user
        expense.save
        expect do
            expense.delete
        end.to change(Expense, :count).by(-1)
      end

      it "redirects to the login" do
        expense = Expense.create! valid_attributes
        delete expense_url(expense)
        expect(response).to redirect_to(new_user_session_url)
      end
end

      
context 'saving' do
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
    
        it "renders the index template" do
          saving = Saving.new(valid_attributes)
          saving.user = current_user
          saving.save
          get savings_url
          expect response.success?
        end
    end
      
      
    
        it "renders the new saving path from dashboard" do
          get new_saving_url
          expect response.success?
        end
    
        it "renders the edit saving path from dashboard" do
          saving = Saving.new(valid_attributes)
          saving.user = current_user
          saving.save
          get edit_saving_url(saving)
          expect response.success?
        end
    
     context "creates a new saving from dashboard" do
          it "creates a new saving" do
            expect do
              saving = Saving.new(valid_attributes)
              saving.user = current_user
              saving.save
              post savings_url, params: { saving: valid_attributes }
          end.to change(Saving, :count).by(1)
        end
     
    
      it "redirects to the login" do
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
        it "redirects to the saving" do
          saving = Saving.create! valid_attributes
       patch saving_url(saving), params: { saving: new_attributes }
       saving.reload
       expect(response).to redirect_to(new_user_session_url)
    
     end
    
    
        it 'destroys the requested  saving' do
          saving = Saving.new(valid_attributes)
          saving.user = current_user
          saving.save
          expect do
            saving.delete
          end.to change(Saving, :count).by(-1)
        end
    
        it "redirects to the login" do
          saving = Saving.create! valid_attributes
          delete saving_url(saving)
          expect(response).to redirect_to(new_user_session_url)
        end
    
end
end