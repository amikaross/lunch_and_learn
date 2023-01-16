require 'rails_helper'

RSpec.describe 'recipes request API' do 
  describe 'get recipes by country' do 
    it 'returns a collection of recipes for a given country' do 
      VCR.use_cassette('thailand_recipes') do 
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

          expect(recipe[:attributes]).to_not have_key(:ingredients)
          expect(recipe[:attributes]).to_not have_key(:calories)
        end
      end
    end

    it 'returns a collection of recipes for a random country if none is provided' do 
      allow(RecipesFacade).to receive(:get_random_country).and_return("Republic of Kosovo")

      VCR.use_cassette('random_country_recipes') do 
        get '/api/v1/recipes'

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

          expect(recipe[:attributes]).to_not have_key(:ingredients)
          expect(recipe[:attributes]).to_not have_key(:calories)
        end
      end
    end
  end
end