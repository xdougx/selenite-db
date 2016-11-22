module Selenite
  module DB
    module Atributtor
  
      macro set_property(*names)
        property({{*names}})

        def properties
          properties = [] of String

          {% for name in names %}
            properties << "{{name}}"
          {% end %}

          properties
        end
      end

      macro set_initializer(*names)
      
        def initialize(hash : Hash)
          set_defaults
          {% for name in names %}
            @{{name}} = hash.fetch("{{name}}") if hash.has_key?("{{name}}")
          {% end %}
        end
        
        def initialize
          set_defaults
          {% for name in names %}
            @{{name}} = ""
          {% end %}
        end

        def attributes
          {
          {% for name in names %}
            "{{name}}" => self.{{name}},
          {% end %}
          }
        end
      end


    end
  end
end