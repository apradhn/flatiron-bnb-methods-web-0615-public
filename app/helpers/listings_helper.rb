module ListingsHelper

  module InstanceMethods

    def average_review_rating
      listing = Listing.find(self.id)
      total = listing.reviews.inject(0){|sum, review| sum + review.rating}
      total.to_f / listing.reviews.size
    end    

    def available_for?(checkin, checkout)
      self.reservations.any? do |reservation|
        false if checkin.between?(reservation.checkin, reservation.checkout) && checkout.between?(reservation.checkin, reservation.checkout)
      end
    end

  end

  module ClassMethods


  end
end
