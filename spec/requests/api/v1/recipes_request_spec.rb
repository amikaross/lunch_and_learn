require 'rails_helper'

RSpec.describe 'recipes request API' do 
  describe 'get recipes by country' do 
    it 'returns a collection of recipes for a given country' do 
      get '/api/v1/recipes?country=thailand'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      recipes = response_body[:data]

      expect(recipes).to be_an(Array)

      recipes.each do |recipe|
        expect(recipe).to be_a(Hash)
        expect(recipe[:id]).to eq(nil)
        expect(recipe[:type]).to eq("recipe")
        expect(recipe[:attributes]).to be_a(Hash)
        expect(recipe[:attributes][:title]).to be_a(String)
        expect(recipe[:attributes][:url]).to be_a(String)
        expect(recipe[:attributes][:country]).to be_a(String)
        expect(recipe[:attributes][:image]).to be_a(String)

        expect(recipe[:attributes]).to_not have_key(:UPDATE_TO_DO)
      end
    end
  end
end