require 'rails_helper'

RSpec.describe CountryService do 
  describe 'class methods' do 
    describe '::get_country' do 
      it 'returns a list of parsed countries with sybmolized names' do 
        VCR.use_cassette('service_get_country') do 
          countries = CountryService.get_country

          expect(countries).to be_an(Array)

          countries.each do |country|
            expect(country).to have_key(:name)
            expect(country[:name]).to have_key(:official)
            expect(country[:name][:official]).to be_a(String)
          end
        end
      end
    end

    describe '::conn' do 
      it 'returns a Faraday Connection to restcountries.com' do 
        conn = CountryService.conn 

        expect(conn).to be_a(Faraday::Connection)
        expect(conn.url_prefix.hostname).to eq('restcountries.com')
      end
    end
  end
end