require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user_name_no_precense){FactoryBot.build(:user,name:"   ")}
    let(:user_email_no_precense){FactoryBot.build(:user,email:"   ")}
    let(:user_name_over_50_chars){FactoryBot.build(:user,name:"a" * 51, email:"hoge@example.com")}
    let(:user_email_over_255_chars){FactoryBot.build(:user,email:"a" * 244 + "@example.com")}
    it 'name is invalid' do
      expect(user_name_no_precense).not_to be_valid
    end
    it 'email is invalid' do
      expect(user_email_no_precense).not_to be_valid
    end
    it 'name is invalid' do
      expect(user_name_over_50_chars).not_to be_valid
    end
    it 'email is invalid' do
      expect(user_email_over_255_chars).not_to be_valid
    end
    it 'email is invalid' do
      user = User.new(name: "Alice", email: "old_email@example.com")
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid? #run validation. necessary.
        expect(user.errors.full_messages).to include("Email is invalid")
      end
    end
    
  end
end
