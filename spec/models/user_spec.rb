require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user_name_no_precense){FactoryBot.build(:user,name:"   ")}
    let(:user_email_no_precense){FactoryBot.build(:user,email:"   ")}
    let(:user_name_over_50_chars){FactoryBot.build(:user,name:"a" * 51, email:"hoge@example.com")}
    let(:user_email_over_255_chars){FactoryBot.build(:user,email:"a" * 244 + "@example.com")}
    let(:user_password_blank){FactoryBot.build(:user,password:" " * 6)}
    let(:user_password_max_5_chars){FactoryBot.build(:user,password:"a" * 5)}
    it 'name is invalid' do
      expect(user_name_no_precense).not_to be_valid
      expect(user_name_no_precense.errors.full_messages).to eq(["Name can't be blank"])
    end
    it 'email is invalid' do
      expect(user_email_no_precense).not_to be_valid
      expect(user_email_no_precense.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
    end
    it 'name is invalid' do
      expect(user_name_over_50_chars).not_to be_valid
      expect(user_name_over_50_chars.errors.full_messages).to eq(["Name is too long (maximum is 50 characters)"])
    end
    it 'email is invalid' do
      expect(user_email_over_255_chars).not_to be_valid
      expect(user_email_over_255_chars.errors.full_messages).to eq(["Email is too long (maximum is 255 characters)"])
    end
    it 'email is invalid' do
      user = User.new(name: "Alice", email: "old_email@example.com",password:"foobar")
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid? #run validation. necessary.
        expect(user.errors.full_messages).to eq(["Email is invalid"])
      end
    end
    it 'password and password_confirmation must match' do
      user = User.new(name: "Alice", email: "old_email@example.com",password:"foobar",password_confirmation:"barfoo")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
    end
    it 'email should be unique' do
      user = User.new(name: "Alice", email: "old_email@example.com",password:"foobar")
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to eq(["Email has already been taken"])
    end
    it 'password is invalid' do
      expect(user_password_blank).not_to be_valid
      expect(user_password_blank.errors.full_messages).to eq(["Password can't be blank"])
    end
    it 'password is invalid' do
      expect(user_password_max_5_chars).not_to be_valid
      expect(user_password_max_5_chars.errors.full_messages).to eq(["Password is too short (minimum is 6 characters)"])
    end
    
  end
end
