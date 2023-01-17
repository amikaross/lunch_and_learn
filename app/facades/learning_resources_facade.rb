class LearningResourcesFacade
  def self.get_learning_resource(country)
    images = get_country_images(country)
    video = get_video(country)
    LearningResource.new(country, video, images)
  end

  def self.get_country_images(country)
    images_data = unsplash_service.images_by_country(country)[:results]
    images_data.map { |data| Image.new(data) }
  end

  def self.get_video(country)
    video_data = youtube_service.video_by_country(country)[:items][0]
    video_data.nil? ? {} : Video.new(video_data)
  end

  def self.unsplash_service
    UnsplashService.new
  end

  def self.youtube_service
    YoutubeService.new
  end
end