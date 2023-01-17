require 'rails_helper'

RSpec.describe LearningResource do 
  it 'exists and has readabale attributes' do 
    VCR.use_cassette('learning_resource_thailand') do 
      video = LearningResourcesFacade.get_video('thailand')
      images = LearningResourcesFacade.get_country_images('thailand')
      country = 'thailand'

      resource = LearningResource.new(country, video, images)

      expect(resource).to be_an_instance_of(LearningResource)
      expect(resource.country).to eq('thailand')
      expect(resource.video).to be_a(Video)
      expect(resource.images).to be_an(Array)
    end
  end
end