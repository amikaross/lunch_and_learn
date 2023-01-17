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

  describe 'get a users favorites' do 
    it 'can return a list of favorites associated with a valid user' do 
      user = create(:user, api_key: "jgn983hy48thw9begh98h4539h4k")
      create_list(:favorite, 4, user: user)

      get "/api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4k"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)

      response_body[:data].each do |favorite|
        expect(favorite).to have_key(:id)
        expect(favorite[:id]).to be_a(String)

        expect(favorite).to have_key(:type)
        expect(favorite[:type]).to eq('favorite')

        expect(favorite).to have_key(:attributes)
        expect(favorite[:attributes]).to have_key(:recipe_title)
        expect(favorite[:attributes][:recipe_title]).to be_a(String)

        expect(favorite[:attributes]).to have_key(:recipe_link)
        expect(favorite[:attributes][:recipe_link]).to be_a(String)

        expect(favorite[:attributes]).to have_key(:country)
        expect(favorite[:attributes][:country]).to be_a(String)

        expect(favorite[:attributes]).to have_key(:created_at)
        expect(favorite[:attributes][:created_at]).to be_a(String)
      end
    end

    it 'returns an error if the API key does not exist' do 
      user = create(:user, api_key: "jgn983hy48thw9begh98h4539h4k")

      get "/api/v1/favorites?api_key=kgn983hy48thw9begh98h4539h4j"

      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:message)
      expect(response_body[:message]).to eq("Bad Request")
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("Invalid API Key")
    end

    it 'returns data:[] if the user has no favorites' do 
      user = create(:user, api_key: "jgn983hy48thw9begh98h4539h4k")

      get "/api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4k"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to eq([])
    end
  end
end