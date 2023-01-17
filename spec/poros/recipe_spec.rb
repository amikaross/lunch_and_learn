require 'rails_helper'

RSpec.describe Recipe do 
  it 'exists and has readabale attributes' do 
    recipe_data = {:recipe=>
                    {
                      :uri=>"http://www.edamam.com/ontologies/edamam.owl#recipe_463e5568adf283d8f3c8e08cb01184b3",
                      :label=>"Coconut Curry Puffs",
                      :image=>"https://edamam-product-images.s3.amazonaws.com",
                      :url=>"http://www.food52.com/recipes/10992_coconut_curry_puffs"
                    }
                  }
    recipe = Recipe.new(recipe_data, 'Malaysia')

    expect(recipe).to be_an_instance_of(Recipe)
    expect(recipe.title).to eq('Coconut Curry Puffs')
    expect(recipe.url).to eq('http://www.food52.com/recipes/10992_coconut_curry_puffs')
    expect(recipe.country).to eq('Malaysia')
    expect(recipe.image).to eq('https://edamam-product-images.s3.amazonaws.com')
  end
end
