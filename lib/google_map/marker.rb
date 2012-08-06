module GoogleMap

  class Marker

    include ActionView::Helpers::JavaScriptHelper

    attr_accessor :dom_id,
                  :lat,
                  :lng,
                  :map,
                  :icon

    def initialize(options = {})
      self.icon = GoogleMap::MarkerImage.new

      options.each_pair { |key, value| send("#{key}=", value) }

      if lat.blank? or lng.blank? or !map or !map.kind_of?(GoogleMap::Map)
        raise "Must set lat, lng, and map for GoogleMapMarker."
      end

      if dom_id.blank?
        # This needs self to set the attr_accessor, why?
        self.dom_id = "#{map.dom_id}_marker_#{map.markers.size + 1}"
      end

    end

    def icon_js
      @icon.kind_of?(GoogleMap::MarkerImage) ? @icon.to_js : "'#{@icon}'"
    end

    def position
      GoogleMap::Point.new(lat, lng)
    end

    def to_js
      js = []

      js << "var #{dom_id} = new google.maps.Marker({"
      js << "  map: #{map.dom_id}, "
      js << "  position: #{position.to_js},"
      js << "  icon: #{icon_js}"
      js << "});"

      return js.join("\n")
    end

  end

end
