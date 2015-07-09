module CitiesHelper

  module InstanceMethods
    def city_openings(start_date, end_date)
      # knows about all the available listings given a date range
      # binding.pry
      self.listings.select do |listing|
        listing.reservations.none? do |reservation|
          reservation.checkin >= start_date.to_date && reservation.checkout <= end_date.to_date
        end
      end
    end 

  end

  module ClassMethods
    def highest_ratio_res_to_listings
      # knows the city with the highest ratio of reservations to listings

      ratios = self.all.each_with_object({}) do |city, hash|
        data = self.includes(:reservations, :listings)
        reservations_count = data.group(:reservations).having("cities.name = ?", city.name)
        listings_count = data.group(:listings).having("cities.name = ?", city.name)
        hash[city.name] = reservations_count / listings_count
        binding.pry
      end
    end
  end
end
