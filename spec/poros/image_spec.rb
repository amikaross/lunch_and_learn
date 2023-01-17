require 'rails_helper'

RSpec.describe Image do 
  it 'exists and has readable attributes' do 
    image_data = {
      :id=>"gsllxmVO4HQ",
      :alt_description=>"standing statue and temples landmark during daytime",
      :urls=>
      {
        :raw=>"https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzOTk4ODl8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NzM5NjA0NjE&ixlib=rb-4.0.3",
        :full=>
        "https://images.unsplash.com/photo-1528181304800-259b08848526?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzOTk4ODl8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NzM5NjA0NjE&ixlib=rb-4.0.3&q=80",
        :regular=>
        "https://images.unsplash.com/photo-1528181304800-259b08848526?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTk4ODl8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NzM5NjA0NjE&ixlib=rb-4.0.3&q=80&w=1080"
      }
    }

    image = Image.new(image_data)

    expect(image).to be_an_instance_of(Image)
    expect(image.alt_tag).to eq('standing statue and temples landmark during daytime')
    expect(image.url).to eq('https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzOTk4ODl8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NzM5NjA0NjE&ixlib=rb-4.0.3')
  end
end