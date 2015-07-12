module ListingsHelper

  module InstanceMethods

    def average_review_rating
      listing = Listing.find(self.id)
      total = listing.reviews.inject(0){|sum, review| sum + review.rating}
      total.to_f / listing.reviews.size
    end    

    def available_at_checkin?(pending_reservation)
      if reservations.empty?
        true
      elsif !(pending_reservation.checkin.nil? || pending_reservation.checkout.nil?)
        reservations.none? {|r|  pending_reservation.status == "pending" && pending_reservation.checkin.between?(r.checkin, r.checkout)}
      end
    end

    def available_at_checkout?(pending_reservation)
      if reservations.empty?
        true
      elsif !(pending_reservation.checkin.nil? || pending_reservation.checkout.nil?)
        reservations.none? {|r|  pending_reservation.status == "pending" && pending_reservation.checkout.between?(r.checkin, r.checkout)}
      end
    end    

  end

  module ClassMethods


  end
end
