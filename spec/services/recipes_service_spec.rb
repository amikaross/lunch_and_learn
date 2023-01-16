require 'rails_helper'

RSpec.describe RecipesService do 
  describe 'class methods' do 
    describe '::recipes_by_country' do 
      it 'returns a parsed JSON array of recipes with symbolized names for a given country' do 
        VCR.use_cassette('service_recipes_by_country') do 
          recipes = RecipesService.recipes_by_country('Vietnam')

          expect(recipes).to be_an(Array)

          recipes.each do |recipe|
            expect(recipe).to have_key(:recipe)
            expect(recipe[:recipe]).to be_a(Hash)
            expect(recipe[:recipe]).to have_key(:label)
            expect(recipe[:recipe][:label]).to be_a(String)
            expect(recipe[:recipe]).to have_key(:url)
            expect(recipe[:recipe][:url]).to be_a(String)
            expect(recipe[:recipe]).to have_key(:image)
            expect(recipe[:recipe][:image]).to be_a(String)
          end
        end
      end
    end

    describe '::conn' do 
      it 'returns a Faraday Connection to api.edamam.com' do 
        conn = RecipesService.conn 
        
        expect(conn).to be_a(Faraday::Connection)
        expect(conn.url_prefix.hostname).to eq('api.edamam.com')
      end
    end
  end
end