module GoogleMap

  class Controls
    attr_accessor :controls

    def initialize(options = {})
      self.controls = {
        :pan => true,
        :zoom => true,
        :map_type => true,
        :scale => true,
        :street_view => true,
        :overview_map => true
      }.merge(options)
    end

    def to_js
      js = []

      controls.each do |name, value|
        js << "#{name.to_s.camelize(:lower)}Control: #{value.to_s}"
      end

      js.join(",\n")
    end

  end

end
