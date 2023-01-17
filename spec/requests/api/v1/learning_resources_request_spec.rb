require 'rails_helper'

RSpec.describe 'learning resources request API' do 
  describe 'get learning resources by country' do 
    it 'returns a learning resource object associated with a given country' do 
      VCR.use_cassette('laos_resources') do 
        get '/api/v1/learning_resources?country=laos'

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        resource = response_body[:data]

        expect(resource[:id]).to eq(nil)
        expect(resource[:type]).to eq('learning_resource')
        expect(resource).to have_key(:attributes)
        expect(resource[:attributes]).to be_a(Hash)
        expect(resource[:attributes][:country]).to eq('laos')
        expect(resource[:attributes][:video]).to be_a(Hash)
        expect(resource[:attributes][:video][:title]).to be_a(String)
        expect(resource[:attributes][:video][:youtube_video_id]).to be_a(String)
        expect(resource[:attributes][:images]).to be_an(Array)
        resource[:attributes][:images].each do |image|
          expect(image).to be_a(Hash)
          expect(image[:alt_tag]).to be_a(String)
          expect(image[:url]).to be_a(String)
        end
      end
    end

    it 'should return video: {} and/or images: [] if one is not found' do 
      VCR.use_cassette('no_images_found') do 
        get '/api/v1/learning_resources?country=amandaross'

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        resource = response_body[:data]

        expect(resource[:attributes][:video]).to eq({})
        expect(resource[:attributes][:images]).to eq([])
      end
    end
  end
end