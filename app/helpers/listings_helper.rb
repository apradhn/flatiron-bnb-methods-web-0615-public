module ListingsHelper

  module InstanceMethods

    def average_review_rating
      listing = Listing.find(self.id)
      total = listing.reviews.inject(0){|sum, review| sum + review.rating}
      total.to_f / listing.reviews.size
    end    

  end

  module ClassMethods


  end
end
