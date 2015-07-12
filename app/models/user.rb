class User < ActiveRecord::Base
  # Host associations
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings, inverse_of: :user
  has_many :guests, through: :reservations
  has_many :hosts

  # Guest associations
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  has_many :hosts, through: :trips  

  def host_reviews
    self.listings.collect{|listing| listing.reviews}.flatten
  end

end
