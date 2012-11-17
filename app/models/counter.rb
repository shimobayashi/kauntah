class Counter < ActiveRecord::Base
  attr_accessible :count, :owner
end
