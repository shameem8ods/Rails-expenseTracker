require 'rails_helper'

RSpec.describe User, type: :model do

context 'validation test' do
    it 'is user valid' do
      user = User.create(
         email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it 'is user valid without email' do
      user = User.create(
         email: '',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to_not be_valid
    end

    it 'is user valid without correct email format' do
      user = User.create(
         email: 'testexample',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to_not be_valid
    end

    it 'is user valid when password and confirm password not match' do
      user = User.create(
         email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password123'
      )
      expect(user).to_not be_valid
    end

 end
end
