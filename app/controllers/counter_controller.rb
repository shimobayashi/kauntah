require 'RMagick'

class CounterController < ApplicationController
  def index
  end

  def counter
    count = 4644;

    images = []
    for n in count.to_s.split(//u)
      images << File.expand_path("app/assets/images/nekomimi/#{n}.gif", Rails.root)
    end

    list = Magick::ImageList.new(*images)
    image = list.append(false)

    self.content_type = image.mime_type
    self.response_body = image.to_blob
  end
end
