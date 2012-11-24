module GoogleMap
  class Map
    #include Reloadable
    include UnbackedDomId
    attr_accessor :dom_id,
      :markers,
      :overlays,
      :controls,
      :control_options,
      :inject_on_load,
      :zoom,
      :center,
      :double_click_zoom,
      :continuous_zoom,
      :scroll_wheel_zoom,
      :bounds,
      :map_type,
      :google_api_key

    def initialize(options = {})
      self.dom_id = 'google_map'
      self.zoom = 13
      self.controls = GoogleMap::Controls.new
      self.map_type = 'ROADMAP'
      self.markers = []
      self.overlays = []
      self.bounds = []
      self.control_options = []
      self.double_click_zoom = true
      self.continuous_zoom = false
      self.scroll_wheel_zoom = false
      options.each_pair { |key, value| send("#{key}=", value) }
    end

    def to_html
      html = []

      html << "<script type=\"text/javascript\">\n/* <![CDATA[ */\n"
      html << to_js
      html << "/* ]]> */</script> "

      return html.join("\n").html_safe
    end

    def to_enable_prefix true_or_false
      true_or_false ? "enable" : "disable"
    end

    def to_js
      js = []


      markers.each { |marker| js << "var #{marker.dom_id};" }

      js << "function initializeMap#{dom_id}() {"
      js << "  var #{dom_id};"
      js << "  var #{dom_id}Options;"

      js << "  #{dom_id}Options = #{map_options_js}"
      js << "  #{dom_id} = new google.maps.Map(document.getElementById('#{dom_id}'), #{dom_id}Options);"

      # Put all the markers on the map.
      markers.each do |marker|
        js << '  ' + marker.to_js
      end

      js << '  ' + center_map_js
      js << "}"

      js << "function loadMap#{dom_id}Script() {"
      js << "  var script = document.createElement('script');"
      js << "  script.type = 'text/javascript';"
      js << "  script.src = 'http://maps.googleapis.com/maps/api/js?sensor=false&callback=initializeMap#{dom_id}';"
      js << "  document.body.appendChild(script);"
      js << "}"

      # Load the map on window load preserving anything already on window.onload.
      js << "if (typeof window.onload != 'function') {"
      js << "  window.onload = loadMap#{dom_id}Script;"
      js << "} else {"
      js << "  beforeLoadMap#{dom_id}Script = window.onload;"
      js << "  window.onload = function() {"
      js << "    beforeLoadMap#{dom_id}Script();"
      js << "    loadMap#{dom_id}Script();"
      js << "  }"
      js << "}"

      return js.join("\n")
    end

    def map_options_js
      js = []

      js << "{"
      js << "  zoom: #{zoom},"
      js << "  mapTypeId: google.maps.MapTypeId.#{map_type.to_s.upcase},"
      js << controls.to_js
      js << "};"

      js.join("\n")
    end

    def center_map_js
      set_center_js = []

      if self.center
        set_center_js << "#{dom_id}.setCenter(new google.maps.LatLng(#{center.lat}, #{center.lng}));"
      elsif !markers.present?
        set_center_js << "#{dom_id}.setCenter(new google.maps.LatLng(0, 0));"
      elsif markers.size == 1
        set_center_js << "#{dom_id}.setCenter(new google.maps.LatLng(#{markers.first.lat}, #{markers.first.lng}));"
      else
        set_center_js << "var #{dom_id}_latlng_bounds = new google.maps.LatLngBounds();"

        markers.each do |point|
          set_center_js << "#{dom_id}_latlng_bounds.extend(new google.maps.LatLng(#{point.lat}, #{point.lng}));"
        end

        set_center_js << "#{dom_id}.fitBounds(#{dom_id}_latlng_bounds);"
      end

      set_center_js.join("\n")
    end

    def div(width = '100%', height = '100%')
      "<div id='#{dom_id}' style='width: #{width}; height: #{height}'></div>".html_safe
    end

  end
end
