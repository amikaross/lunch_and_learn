require 'rails_helper'

RSpec.describe 'favorite request API' do 
  describe 'add favorites' do 
    it 'can create a favorite for an existing user' do 
      user = create(:user, api_key: "jgn983hy48thw9begh98h4539h4k")
      favorite_info = {
                        "api_key": "jgn983hy48thw9begh98h4539h4k",
                        "country": "thailand",
                        "recipe_link": "https://www.tastingtable.com/.....",
                        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
                      }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      expect(user.favorites.length).to eq(0)

      post "/api/v1/favorites", headers: headers, params: JSON.generate(favorite_info)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      user.reload
      expect(user.favorites.length).to eq(1)

      created_favorite = Favorite.last 

      expect(created_favorite.country).to eq('thailand')
      expect(created_favorite.recipe_link).to eq('https://www.tastingtable.com/.....')
      expect(created_favorite.recipe_title).to eq('Crab Fried Rice (Khaao Pad Bpu)')
      expect(created_favorite.user).to eq(user)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:success)
      expect(response_body[:success]).to eq('Favorite added successfully')
    end

    it 'returns an error if the user does not exist' do 
      user = create(:user, api_key: "jgn983hy48thw9begh98h4539h4k")

      favorite_info = {
                        "api_key": "kgn983hy48thw9begh98h4539h4j",
                        "country": "thailand",
                        "recipe_link": "https://www.tastingtable.com/.....",
                        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
                      }
      headers = {"CONTENT_TYPE" => "application/json"}

      expect(user.favorites.length).to eq(0)

      post "/api/v1/favorites", headers: headers, params: JSON.generate(favorite_info)

      expect(response.status).to eq(400)

      user.reload
      expect(user.favorites.length).to eq(0)                
      
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:message)
      expect(response_body[:message]).to eq('Bad Request')
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq('Invalid API Key')
    end

    it 'returns an error if its missing any required attributes' do 
      user = create(:user, api_key: "jgn983hy48thw9begh98h4539h4k")
      favorite_info = {
                        "api_key": "jgn983hy48thw9begh98h4539h4k",
                        "country": "thailand"
                      }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      expect(user.favorites.length).to eq(0)

      post "/api/v1/favorites", headers: headers, params: JSON.generate(favorite_info)

      expect(response.status).to eq(400)

      user.reload
      expect(user.favorites.length).to eq(0)                
      
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:message)
      expect(response_body[:message]).to eq('Bad Request')
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq(["Recipe link can't be blank", "Recipe title can't be blank"])
    end
  end
end