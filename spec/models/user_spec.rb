require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_name_no_precense){FactoryBot.build(:user,name:"   ")}
  let(:user_email_no_precense){FactoryBot.build(:user,email:"   ")}
  describe 'precense' do
    it 'name is invalid' do
      expect(user_name_no_precense).not_to be_valid
    end
    it 'email is invalid' do
      expect(user_email_no_precense).not_to be_valid
    end
    
  end
end
