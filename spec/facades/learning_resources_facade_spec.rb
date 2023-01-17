require 'rails_helper'

RSpec.describe LearningResourcesFacade do 
  describe 'class methods' do 
    describe '::get_learning_resource' do 
      it 'returns a learning resource object for a given country' do 
        VCR.use_cassette('learning_resource_thailand') do 
          resource = LearningResourcesFacade.get_learning_resource('thailand')

          expect(resource).to be_an_instance_of(LearningResource)
          expect(resource.country).to eq('thailand')
          expect(resource.video).to be_an_instance_of(Video)
          expect(resource.images).to be_an(Array)
          resource.images.each do |image|
            expect(image).to be_an_instance_of(Image)
          end
        end
      end
    end

    describe '::get_country_images' do 
      it 'returns an array of Image objects resulting from unsplash image search' do 
        VCR.use_cassette('egypt_images') do 
          images = LearningResourcesFacade.get_country_images('egypt')
          
          expect(images).to be_an(Array)
          images.each do |image|
            expect(image).to be_an_instance_of(Image)
            expect(image.alt_tag).to be_a(String)
            expect(image.url).to be_a(String)
          end
        end
      end
    end

    describe '::get_video' do 
      it 'returns a video object (or empty hash if none is found' do 
        VCR.use_cassette('learning_resource_thailand') do 
          video = LearningResourcesFacade.get_video('thailand')

          expect(video).to be_an_instance_of(Video)
          expect(video.title).to be_a(String)
          expect(video.youtube_video_id).to be_a(String)
        end

        VCR.use_cassette('no_video_found') do 
          video = LearningResourcesFacade.get_video('LeeSaville')

          expect(video).to eq({})
        end
      end
    end

    describe '::unsplash_service' do 
      it 'returns an instance of UnsplashService' do 
        service = LearningResourcesFacade.unsplash_service
        
        expect(service).to be_an_instance_of(UnsplashService)
      end
    end

    describe '::youtube_service' do 
      it 'returns an instance of YoutubeService' do 
        service = LearningResourcesFacade.youtube_service

        expect(service).to be_an_instance_of(YoutubeService)
      end
    end
  end
end