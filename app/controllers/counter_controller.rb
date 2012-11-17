require 'RMagick'

class CounterController < ApplicationController
  def index
  end

  def counter
    # Setup
    request.referer =~ /^http:\/\/(.+?)\/.*$/
    owner = $1
    counter = Counter.find_by_owner(owner) || Counter.new(:owner => owner)
    offset = params[:offset] ? params[:offset].to_i : 0
    count = counter.count + offset

    # Generate image
    unless (image = Rails.cache.read("counter_#{count}"))
      images = []
      for n in count.to_s.split(//u)
        images << File.expand_path("app/assets/images/nekomimi/#{n}.gif", Rails.root)
      end
      list = Magick::ImageList.new(*images)
      image = list.append(false)
      Rails.cache.write("counter_#{count}", image)
      logger.info "cached:counter_#{count}"
    end

    # Increment
    counter.count += 1
    counter.save!

    # Response
    self.content_type = image.mime_type
    self.response_body = image.to_blob
  end
end
