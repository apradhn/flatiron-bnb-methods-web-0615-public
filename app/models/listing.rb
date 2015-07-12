class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations, inverse_of: :listing
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  include ListingsHelper::InstanceMethods
  extend ListingsHelper::ClassMethods

  # Validations
  validates :address, :listing_type, :title, :description, :price, :neighborhood, presence: true
  # validates_associated :reservations
  # Callback registrations
  after_create :change_user_host_status_to_true
  after_destroy :change_user_host_status_to_false

  private
  def change_user_host_status_to_true
    host = self.host
    host.host = true
    host.save
  end

  def any_listings?
    self.host.listings.length == 0
  end

  def change_user_host_status_to_false
    if any_listings?
      host = self.host
      host.host = false
      host.save
    end
  end
end
