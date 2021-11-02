require 'rails_helper'

RSpec.describe Expense, type: :model do
  
  current_user = User.first_or_create!(email:'john@example.com',password:"password",password_confirmation:"password")
 
  it 'has an expense type' do
    expense = Expense.new(
      expense_type: '',
      amount: '5000',
      date: '29-10-2021',
      user: current_user

    )
    expect(expense).to_not be_valid
    expense.expense_type = 'has a name'
    expect(expense).to be_valid
  end


  it 'has an amount' do
    expense = Expense.new(
      expense_type: 'rent',
      amount: '',
      date: '29-10-2021',
      user: current_user

    )
    expect(expense).to_not be_valid
    expense.amount = '10000'
    expect(expense).to be_valid
  end

  it 'is it valid without date' do
    expense = Expense.new(
      expense_type: 'rent',
      amount: '5000',
      date: '',
      user: current_user
    )
    expect(expense).to be_valid
  end


end