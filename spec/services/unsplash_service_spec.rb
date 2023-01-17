require 'rails_helper'

RSpec.describe UnsplashService do 
  describe 'instance methods' do 
    describe '#images_by_country' do 
      it 'returns parsed json collection of images related to that country' do 
        VCR.use_cassette('tahiti_images') do 
          service = UnsplashService.new
          response_body = service.images_by_country('Tahiti')

          expect(response_body).to be_a(Hash)
          expect(response_body).to have_key(:results)
          expect(response_body[:results]).to be_an(Array)
          expect(response_body[:results].length).to eq(10)

          response_body[:results].each do |image|
            expect(image).to be_a(Hash)
            expect(image).to have_key(:alt_description)
            if !image[:alt_description].nil? 
              expect(image[:alt_description]).to be_a(String)
            end
            expect(image).to have_key(:urls)
            expect(image[:urls]).to have_key(:raw)
            expect(image[:urls][:raw]).to be_a(String)
          end
        end
      end
    end

    describe '#conn' do 
      it 'returns a Faraday connection with api.unsplash.com' do 
        conn = UnsplashService.new.conn

        expect(conn).to be_a(Faraday::Connection)
        expect(conn.url_prefix.hostname).to eq('api.unsplash.com')
      end
    end
  end
end