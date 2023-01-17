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

      expect(response).to be_successful 
      expect(response.status).to eq(201)
      expect(User.all.length).to eq(1)

      created_user = User.last

      expect(created_user.name).to eq('Haku Dog')
      expect(created_user.email).to eq('hakudog@example.com')
      expect(created_user.api_key).to be_a(String)
      expect(created_user.api_key.length).to eq(28)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data][:type]).to eq("user")
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data][:id]).to be_a(String)
      expect(response_body[:data]).to have_key(:attributes)

      expect(response_body[:data][:attributes]).to have_key(:name)
      expect(response_body[:data][:attributes][:name]).to eq('Haku Dog')

      expect(response_body[:data][:attributes]).to have_key(:email)
      expect(response_body[:data][:attributes][:email]).to eq('hakudog@example.com')

      expect(response_body[:data][:attributes]).to have_key(:api_key)
      expect(response_body[:data][:attributes][:api_key]).to be_a(String)
    end

    it 'responds with an error if you try to create a user with an email that already exists' do 
      create(:user, email: 'frodobaggins@example.com')

      user_info = {
        name: 'Frodo Baggins',
        email: 'frodobaggins@example.com'
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      expect(User.all.length).to eq(1)

      post "/api/v1/users", headers: headers, params: JSON.generate(user_info)

      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Bad Request")
      expect(response_body[:errors]).to eq(["Email has already been taken"])
    end
  end
end