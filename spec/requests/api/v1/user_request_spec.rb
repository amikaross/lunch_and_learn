require 'rails_helper'

RSpec.describe 'user request API' do 
  describe 'user registration' do 
    it 'can create a user' do
      user_info = {
                    name: 'Haku Dog',
                    email: 'hakudog@example.com'
                  }
      headers = {"CONTENT_TYPE" => "application/json"}

      expect(User.all.length).to eq(0)

      post "/api/v1/users", headers: headers, params: JSON.generate(user_info)

      expect(User.all.length).to eq(1)

      created_user = User.last

      expect(created_user.name).to eq('Haku Dog')
      expect(created_user.email).to eq('hakudog@example.com')
      expect(created_user.api_key).to be_a(String)
      expect(created_user.api_key.length).to eq(28)
    end
  end
end