module GoogleMap

  class Point
    attr_accessor :lat,
                  :lng

    def initialize(lat, lng)
      self.lat = lat
      self.lng = lng
      if lat.blank? or lng.blank?
        raise "Must set lat, lng for google.maps.LatLng"
      end

    end

    def to_js
      return "new google.maps.LatLng(#{self.lat}, #{self.lng})"
    end

  end

end
