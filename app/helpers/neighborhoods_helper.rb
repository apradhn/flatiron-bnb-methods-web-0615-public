module NeighborhoodsHelper

  module InstanceMethods

    def neighborhood_openings(start_date, end_date)
      start_date = start_date.to_date
      end_date = end_date.to_date
      # knows about all the available listings given a date range
      self.listings.select do |listing|
        listing.reservations.any? do |reservation|
          start_date <= reservation.checkin ||  end_date >= reservation.checkout
        end
      end
    end
  end

  module ClassMethods

    def highest_ratio_res_to_listings
      # knows the neighborhood with the highest ratio of reservations to listings
      ratios = self.all.each_with_object({}) do |neighborhood, hash|
        neighborhood.reservations.empty? ? reservations_count = 0 : reservations_count = neighborhood.reservations.size
        neighborhood.listings.empty? ? listings_count = 0 : listings_count = neighborhood.listings.size
        if reservations_count != 0 && listings_count == 0
          hash[neighborhood.name] = reservations_count
        elsif reservations_count == 0 && listings_count != 0 || reservations_count == 0 && listings_count == 0
          hash[neighborhood.name] = 0
        else
          hash[neighborhood.name] = reservations_count.to_f / listings_count.to_f
        end
      end
      highest_ratio = ratios.values.max
      neighborhood = ratios.find{|neighborhood, ratio| ratio == highest_ratio}.first
      self.find_by(name: neighborhood)
    end

    def most_res
      # knows the city with the most reservations
      most_reservations = Neighborhood.all.collect{|neighborhood| neighborhood.reservations.size}.max
      Neighborhood.find{|neighborhood| neighborhood.reservations.size == most_reservations}
    end    
  end
end
