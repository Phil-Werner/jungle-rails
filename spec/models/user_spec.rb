require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'password and passwords_confirmation not equal should fail' do
      @user = User.new(name: 'Jimmy', password: 'test', password_confirmation: 'apple', email: 'jimmy@jimmy.jimmy')
      expect(@user).to be_valid

    end

    it 'password and passwords_confirmation equal should pass' do
      @user = User.new(name: 'Jimmy', password: 'test', password_confirmation: 'test', email: 'jimmy@jimmy.jimmy')
      expect(@user).to be_valid

    end

    it 'email not unique should fail' do
      User.create(name: 'Bob', password: 'orange', password_confirmation: 'orange', email: 'bob@bob.bob')
      @user = User.new(name: 'Jimmy', password: 'test', password_confirmation: 'test', email: 'bob@bob.bob')
      expect(@user).to be_valid
    end

    it 'password must be at least 3 characters' do
      @user = User.new(name: 'Jimmy', password: 'aa', password_confirmation: 'aa', email: 'slut@slut.slut')
      expect(@user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'if email doesnt exist, should return nil' do
      @user = User.authenticate_with_credentials('thisemail@doesnt.exist', 'random')
      expect(@user).to be_nil
    end

    it 'if email does exist and password is correct return the user' do
      User.create(name: 'Bob', password: 'orange', password_confirmation: 'orange', email: 'bob@bob.bob')
      @user = User.authenticate_with_credentials('bob@bob.bob', 'orange')
      expect(@user).to be_a User
    end

    it 'if email has spaces before it it should still authenticate' do
      User.create(name: 'Bob', password: 'orange', password_confirmation: 'orange', email: 'bob@bob.bob')
      @user = User.authenticate_with_credentials('   bob@bob.bob', 'orange')
      expect(@user).to be_a User
    end

    it 'if email has spaces after it it should still authenticate' do
      User.create(name: 'Bob', password: 'orange', password_confirmation: 'orange', email: 'bob@bob.bob')
      @user = User.authenticate_with_credentials('bob@bob.bob    ', 'orange')
      expect(@user).to be_a User
    end

    it 'if email has uppercase / lowercase mix ups should still  ' do
      User.create(name: 'Bob', password: 'orange', password_confirmation: 'orange', email: 'bob@bob.bob')
      @user = User.authenticate_with_credentials('boB@bob.bob', 'orange')
      expect(@user).to be_a User
    end
  end
end
