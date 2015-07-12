class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  delegate :reservations, to: :listing
  has_one :review
  has_one :host, through: :listing

  # Validations
  validates :checkin, :checkout, presence: true
  validate :cannot_make_reservation_on_own_listing
  validate :listing_available_at_checkin
  validate :listing_available_at_checkout
  validate :checkin_less_than_checkout

  # Modules
  include ReservationsHelper::InstanceMethods
  include ReservationsHelper::ClassMethods

  def cannot_make_reservation_on_own_listing
    unless guest.nil?
      if guest.listings.include?(listing)
        errors.add(:listing, "Cannot make reservation on own listing.")
      end
    end
  end

  def listing_available_at_checkin
    unless listing.available_at_checkin?(self)
      errors.add(:listing, "Listing unavailable at checkin.")
    end
  end

  def listing_available_at_checkout
    unless listing.available_at_checkout?(self)
      errors.add(:listing, "Listing unavailable at checkout")
    end
  end

  def checkin_less_than_checkout
    unless errors.any?
      unless checkin < checkout
        errors.add(:checkin, "Checkin must be before checkout.")
      end
    end
  end

end

