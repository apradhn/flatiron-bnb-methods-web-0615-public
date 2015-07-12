class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  # Validations
  validates :rating, :description, presence: true
  validates :reservation, presence: true
  validate :reservation_accepted
  validate :checkout_has_happened

  def reservation_accepted
    # binding.pry
    unless errors.any?
      unless reservation.status == "accepted"
        errors.add(:reservation, "Reservation must be accepted.")
      end
    end
  end

  def checkout_has_happened
    unless created_at.nil?
      unless created_at > reservation.checkout
        errors.add(:created_at, "Review cannot be posted before reservation checkout")
      end
    end    
  end
end
