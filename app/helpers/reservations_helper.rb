module ReservationsHelper
  module ClassMethods
    
  end
  
  module InstanceMethods
    def duration
      self.checkout - self.checkin
    end

    def total_price
      self.listing.price * duration
    end
  end
  
end