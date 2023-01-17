require 'rails_helper'

RSpec.describe RecipesFacade do 
  describe 'class methods' do 
    describe '::recipes_by_country' do 
      it 'returns a collection of recipe objects for a given country' do 
        VCR.use_cassette('recipe_facade_malaysia') do 
          recipes = RecipesFacade.recipes_by_country('Malaysia')

          expect(recipes).to be_an(Array)

          recipes.each do |recipe|
            expect(recipe).to be_an_instance_of(Recipe)
          end
        end
      end

      it 'returns a collection of recipe objects for a random country if none is given' do 
        allow(RecipesFacade).to receive(:get_random_country).and_return("Portugal")

        VCR.use_cassette('recipe_facade_random') do 
          recipes = RecipesFacade.recipes_by_country(nil)

          expect(recipes).to be_an(Array)

          recipes.each do |recipe|
            expect(recipe).to be_an_instance_of(Recipe)
          end
        end
      end
    end

    describe '::get_random_country' do 
      it 'returns a random country name from the Country Service API' do 
        VCR.insert_cassette('facade_get_random_country') 
        
        country_name_1 = RecipesFacade.get_random_country
        
        VCR.eject_cassette('facade_get_random_country')
        VCR.insert_cassette('facade_get_random_country')
        
        country_name_2 = RecipesFacade.get_random_country
   
        expect(country_name_1).to be_a(String)
        expect(country_name_2).to be_a(String)
        expect(country_name_1).to_not eq(country_name_2)

        VCR.eject_cassette('facade_get_random_country')
      end
    end
  end
end