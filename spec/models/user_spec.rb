require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before '' do
      @user = User.new(
        first_name: 'Najma',
        last_name: 'Duale',
        email: 'Najma@example.com',
        password: '12345',
        password_confirmation: '12345'
      )
    end

    it 'dose not save user with password mismatch' do
      @user.password_confirmation = "54321"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it 'dose not save user with short password' do
      @user.password = "543"
      @user.password_confirmation = "543"
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it 'saves a user successfully' do
      @user.save!
      expect(@user.errors.full_messages).to be_empty
    end

    it 'does not save a user with empty first name' do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'does not save a user with empty last name' do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'does not save a user with empty email' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'does not save non unique emails' do
      @newuser = User.new(
        first_name: 'Najma',
        last_name: 'Duale',
        email: 'Najma@example.com',
        password: '12345',
        password_confirmation: '12345'
      )
      @user.save
      @newuser.save
      expect(@newuser.errors.full_messages).to include('Email has already been taken')
    end
  end

  describe '.authenticate_with_credentials' do
    before '' do
      @user = User.new(
        first_name: 'Najma',
        last_name: 'Duale',
        email: 'Najma@example.com',
        password: '12345',
        password_confirmation: '12345'
      )
    end

    it 'authenticate user with correct email and passwor' do
      @user.save
      params = {email: "Najma@example.com", password: "12345"}
      
      expect(User.authenticate_with_credentials(params)).to eq(@user)
    end

    it 'not authenticate user with email and wrong passwor' do
      @user.save
      params = {email: "Najma@example.com", password: "123456"}
      
      expect(User.authenticate_with_credentials(params)).to eq(false)
    end
  end

end
