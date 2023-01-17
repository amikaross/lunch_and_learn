require 'rails_helper'

RSpec.describe User, type: :model do 
  describe 'relationships' do 
    it { should have_many(:favorites) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:api_key) }
  end

  describe 'instance methods' do 
    describe '#generate_api_key' do 
      it 'assigns a 28 character alphanumeric string to the users api_key field' do 
        user = User.new(name: 'Haku Dog', email: 'hakudog@example.com')

        expect(user.api_key).to eq(nil)

        user.save 

        expect(user.api_key).to be_a(String)
        expect(user.api_key.length).to eq(28)
      end
    end
  end
end