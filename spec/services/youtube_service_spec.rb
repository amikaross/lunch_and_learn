require 'rails_helper'

RSpec.describe YoutubeService do 
  describe 'instance methods' do 
    describe '#videos_by_country' do 
      it 'returns a parsed json collection of 1 video' do 
        VCR.use_cassette('portugal_video') do 
          service = YoutubeService.new 
          videos = service.video_by_country('portugal')

          expect(videos).to have_key(:items)
          expect(videos[:items]).to be_an(Array)
          expect(videos[:items].length).to eq(1)

          video = videos[:items][0]

          expect(video).to be_a(Hash)
          expect(video).to have_key(:id)
          expect(video[:id]).to have_key(:videoId)
          expect(video[:id][:videoId]).to be_a(String)
          expect(video).to have_key(:snippet)
          expect(video[:snippet]).to have_key(:title)
          expect(video[:snippet][:title]).to be_a(String)
        end
      end
    end

    describe '#conn' do 
      it 'returns a faraday connection to googleapis.com' do 
        conn = YoutubeService.new.conn 

        expect(conn).to be_a(Faraday::Connection)
        expect(conn.url_prefix.hostname).to eq('www.googleapis.com')
      end
    end
  end
end