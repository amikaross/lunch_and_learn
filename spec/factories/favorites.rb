FactoryBot.define do 
  factory :favorite do 
    user 
    country { Faker::Fantasy::Tolkien.location }
    recipe_link { "www.example.com "}
    recipe_title { Faker::Food.dish }
  end
end