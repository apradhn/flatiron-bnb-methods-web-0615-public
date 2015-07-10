class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  belongs_to :host, :class_name => "User"
  has_one :review
  has_one :host, through: :listing

  # Validations
  # validate :cannot_make_reservation_on_own_listing, on: :create
  # validates :checkin, :checkout, presence: true
  validate :checkin_present, :checkout_present, :cannot_make_reservation_on_own_listing, :listing_must_be_available


  def checkin_present
    unless checkin.present? 
      errors.add(:checkin, "Must be present.")
    end
  end

  def checkout_present
    unless checkout.present?
      errors.add(:checkout, "Must be present.")
    end
  end

  def cannot_make_reservation_on_own_listing
    if guest.listings.include?(listing)
      errors.add(:listing, "Cannot make reservation on own listing.")
    end
  end

  def listing_must_be_available
    binding.pry
    listing.available_for?(checkin, checkout)
  end
end

