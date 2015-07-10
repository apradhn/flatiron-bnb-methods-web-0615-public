class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings
  include NeighborhoodsHelper::InstanceMethods
  extend NeighborhoodsHelper::ClassMethods
end
