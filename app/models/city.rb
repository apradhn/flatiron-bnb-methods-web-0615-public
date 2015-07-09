class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings
  include CitiesHelper::InstanceMethods
  extend CitiesHelper::ClassMethods
end

