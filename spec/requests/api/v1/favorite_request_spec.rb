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
      expect(user.favorites.length).to eq(1)

      created_favorite = Favorite.last 

      expect(created_favorite.country).to eq('thailand')
      expect(created_favorite.recipe_link).to eq('https://www.tastingtable.com/.....')
      expect(created_favorite.recipe_title).to eq('Crab Fried Rice (Khaao Pad Bpu)')
      expect(created_favorite.user).to eq(user)
    end
  end
end