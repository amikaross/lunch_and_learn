require 'rails_helper'

RSpec.describe Video do 
  it 'exists and has readable attributes' do 
    video_data = {:kind=>"youtube#searchResult",
    :etag=>"g_AANaDO0PP_y9-nAEiKyK7DquE",
    :id=>{:kind=>"youtube#video", :videoId=>"uw8hjVqxMXw"},
    :snippet=>
     {:publishedAt=>"2021-08-29T10:13:10Z",
      :channelId=>"UCluQ5yInbeAkkeCndNnUhpw",
      :title=>"A Super Quick History of Laos",
      :description=>"Audio Requiring Attribution: LukeIRL: https://freesound.org/people/LukeIRL/sounds/176134/ RTB45: ...",
      :thumbnails=>
       {:default=>{:url=>"https://i.ytimg.com/vi/uw8hjVqxMXw/default.jpg", :width=>120, :height=>90},
        :medium=>{:url=>"https://i.ytimg.com/vi/uw8hjVqxMXw/mqdefault.jpg", :width=>320, :height=>180},
        :high=>{:url=>"https://i.ytimg.com/vi/uw8hjVqxMXw/hqdefault.jpg", :width=>480, :height=>360}},
      :channelTitle=>"Mr History",
      :liveBroadcastContent=>"none",
      :publishTime=>"2021-08-29T10:13:10Z"}}
    
    video = Video.new(video_data)

    expect(video).to be_an_instance_of(Video)
    expect(video.title).to eq('A Super Quick History of Laos')
    expect(video.youtube_video_id).to eq('uw8hjVqxMXw')
  end
end