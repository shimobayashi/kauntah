require 'RMagick'

class CountersController < ApplicationController
  def index
    @counters = Counter.find(:all, :limit => 10, :order => 'created_at desc')
  end

  def counter
    # Setup
    request.referer =~ /^http:\/\/(.+?)\/.*$/
    owner = $1
    logger.info "owner: #{owner}"
    counter = Counter.find_by_owner(owner) || Counter.new(:owner => owner)
    counter.count += 1
    offset = params[:offset] ? params[:offset].to_i : 0
    count = counter.count + offset

    # Generate image
    key = "counter-#{count}"
    unless (image = Rails.cache.read(key))
      images = []
      for n in count.to_s.split(//u)
        images << File.expand_path("app/assets/images/nekomimi/#{n}.gif", Rails.root)
      end
      list = Magick::ImageList.new(*images)
      image = list.append(false)
      Rails.cache.write(key, image)
      logger.info "cached: #{key}"
    end

    counter.save!

    # Response
    self.headers['Cache-Control'] = 'no-store'
    self.content_type = image.mime_type
    self.response_body = image.to_blob
  end
end
