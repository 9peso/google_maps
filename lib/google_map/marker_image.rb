module GoogleMap

  class MarkerImage
    #include Reloadable
    #include UnbackedDomId

    attr_accessor :width,
                  :height,
                  :scaled_width,
                  :scaled_height,
                  :origin_x,
                  :origin_y,
                  :image_url,
                  :anchor_x,
                  :anchor_y

    def initialize(options = {})
      self.image_url       = 'http://www.google.com/mapfiles/marker.png'
      self.width           = 20
      self.height          = 34
      self.scaled_width    = 20
      self.scaled_height   = 34
      self.origin_x        = 0
      self.origin_y        = 0
      self.anchor_x        = 6
      self.anchor_y        = 20

      options.each_pair { |key, value| send("#{key}=", value) }
    end

    def to_js
      js = []
      js <<  "new google.maps.MarkerImage("
      js <<  "\"#{image_url}\","
      js <<  "new google.maps.Size(#{width}, #{height}),"
      js <<  "new google.maps.Point(#{origin_x}, #{origin_y}),"
      js <<  "new google.maps.Point(#{anchor_x}, #{anchor_y}),"
      js <<  "new google.maps.Size(#{scaled_width}, #{scaled_height})"
      js <<  ")"

      js.join(' ')
    end
  end

end
