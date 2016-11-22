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

      macro set_initializer(timestamps, *names)
        def initialize(hash : Hash)
          {% if timestamps %}
            @created_at = Time.now
            @updated_at = Time.now
          {% end %}

          {% for name in names %}
            @{{name}} = hash.fetch("{{name}}") if hash.has_key?("{{name}}")
          {% end %}
        end
        
        def initialize
          {% if timestamps %}
            @created_at = Time.now
            @updated_at = Time.now
          {% end %}

          {% for name in names %}
            @{{name}} = ""
          {% end %}
        end

        def attributes
          {
          {% for name in names %}
            "{{name}}" => self.{{name}},
          {% end %}
          {% if timestamps %}
            "created_at" => Time.now,
            "updated_at" => Time.now
          {% end %}
          }
        end
      end
    end
  end
end