module GoogleMap

  class SmallIcon < GoogleMap::MarkerImage
    #include Reloadable

    alias_method :parent_initialize, :initialize

    def initialize(map, color = 'red')

      parent_initialize(:width => 12,
                        :height => 20,
                        :scaled_width => 12,
                        :scaled_height => 20,
                        :image_url => "http://labs.google.com/ridefinder/images/mm_20_#{color}.png",
                        :anchor_x => 6,
                        :anchor_y => 20,
                        :map => map)
    end
  end

end
