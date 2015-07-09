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
        reservations_count = city.reservations.size
        listings_count = city.listings.size
        hash[city.name] = reservations_count.to_f / listings_count.to_f
      end
      highest_ratio = ratios.values.max
      city = ratios.find{|city, ratio| ratio == highest_ratio}.first
      self.find_by(name: city)
    end

    def most_res
      # knows the city with the most reservations
      most_reservations = City.all.collect{|city| city.reservations.size}.max
      City.find{|city| city.reservations.size == most_reservations}
    end    
  end

end
