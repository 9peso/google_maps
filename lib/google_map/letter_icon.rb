module GoogleMap

  class LetterIcon < GoogleMap::MarkerImage
    #include Reloadable

    alias_method :parent_initialize, :initialize

    def initialize(map, letter)
      parent_initialize(:map => map, :image_url => "http://www.google.com/mapfiles/marker#{letter}.png")
    end

  end

end
