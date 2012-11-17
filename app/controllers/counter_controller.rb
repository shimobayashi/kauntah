require 'RMagick'

class CounterController < ApplicationController
  def index
  end

  def counter
    img = Magick::Image.read(File.expand_path('app/assets/images/nekomimi/0.gif', Rails.root)).first
    self.content_type = img.mime_type
    self.response_body = img.to_blob
  end
end
