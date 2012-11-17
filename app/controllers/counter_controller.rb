require 'RMagick'

class CounterController < ApplicationController
  def index
  end

  def counter
    list = Magick.ImageList.new
    for i in 0...9
      img = Magick::Image.read(File.expand_path("app/assets/images/nekomimi/#{i}.gif", Rails.root)).first
      list.concat(img)
    end
    list.append(false)
    self.content_type = img.mime_type
    self.response_body = img.to_blob
  end
end
