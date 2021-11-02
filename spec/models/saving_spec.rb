require 'rails_helper'

RSpec.describe Saving, type: :model do
  
  current_user = User.first_or_create!(email:'john@example.com',password:"password",password_confirmation:"password")
 
  it 'has a saving type' do
    saving = Saving.new(
      saving_type: '',
      amount: '5000',
      date: '29-10-2021',
      user: current_user
    )
    expect(saving).to_not be_valid
    saving.saving_type = 'has a name'
    expect(saving).to be_valid
  end


  it 'has a amount' do
    saving = Saving.new(
      saving_type: 'salary',
      amount: '',
      date: '29-10-2021',
      user: current_user

    )
    expect(saving).to_not be_valid
    saving.amount = '10000'
    expect(saving).to be_valid
  end

  it 'is it valid without date' do
    saving = Saving.new(
      saving_type: 'salary',
      amount: '5000',
      date: '',
      user: current_user
    )
    expect(saving).to be_valid
  end


end
