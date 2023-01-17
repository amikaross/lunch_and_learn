FactoryBot.define do 
  factory :user do 
    name { Faker::Name.unique.name }
    email { "#{name.delete(' ')}@example.com".downcase }
    api_key { Faker::Alphanumeric.unique.alphanumeric(number: 28) }
  end
end