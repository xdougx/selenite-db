module DB
  abstract class Model < DB::Base
    abstract def self.table_name : String

    def set_defaults
      @created_at = Time.now if(@created_at == "" || @created_at.nil?) 
      @updated_at = Time.now if(@updated_at == "" || @updated_at.nil?) 
    end

    def table_name
      self.class.table_name
    end

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
        {% for name in names %}
          @{{name}} = hash.fetch("{{name}}") if hash.has_key?("{{name}}")
        {% end %}
        set_defaults
      end
      
      def initialize
        {% for name in names %}
          @{{name}} = "",
        {% end %}
        set_defaults
      end

      def attributes
        {
        {% for name in names %}
          "{{name}}" => self.{{name}},
        {% end %}
        }
      end
    end

    def save
      query = %(INSERT INTO #{table_name} (#{insert_keys}) VALUES(#{insert_values}) RETURNING id;)
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      result = self.class.connection.exec(query)
      if result.rows.size > 0
        self.id = result.rows.first[0]
        true
      else
        false
      end
    end

    def update_columns(params)
      params["updated_at"] = Time.now.to_s
      query = %(UPDATE #{table_name} SET #{update_values(params)} WHERE id = #{@id})
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      result = self.class.connection.exec(query)
      true
    end

    def insert_values
      string = ""
      attributes.each_with_index do |key, value, index|
        next if key == "id"
        if value.is_a?(String)
          string += %('#{scape(value.to_s)}')
        elsif value.is_a?(Int64) || value.is_a?(Int32) 
          string += %(#{value})
        elsif value.is_a?(Time)
          string += %('#{scape(value.to_s)}')
        else
          string += %('#{scape(value.to_s)}')
        end
        string += ", " if index < (attributes.values.size-1)
      end
      string
    end

    def insert_keys
      keys = attributes.keys
      keys.delete("id")
      keys.join(", ")
    end

    def scape(string : String)
      if string.match /(\'|\"|\%)/ 
        string = string.gsub("'", "\'")
        string = string.gsub(/\"/ , "\"")
        string = string.gsub("%", "\%")
      end
      string
    end

    def update_values(params)
      string = ""
      index = 0
      size = params.size
      params.each do |key, value|
        if value.is_a?(String)
          string += %(#{key} = '#{scape(value)}')
        elsif value.is_a?(Int64)
          string += %(#{key} = #{value})
        elsif value.is_a?(Time)
          string += %(#{key} = '#{scape(value.to_s)}')
        else
          string += %(#{key} = '#{scape(value.to_s)}')
        end

        string += ", " if index < (size-1)
        index += 1
      end
      string
    end

    def self.exists?(column, value)
      query = %(SELECT id FROM #{table_name} WHERE #{column} = '#{value}' LIMIT 1;)
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      result = connection.exec(query)
      result.rows.size > 0
    end

    def self.exists?(params)
      where = params.map {|key, val| %(#{table_name}.#{key} = '#{val}') }.join(" AND ")
      query = %(SELECT id FROM #{table_name} WHERE #{where} LIMIT 1;)
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      result = connection.exec(query)
      result.rows.size > 0
    end

    def self.find(id : Int32 | Int64 | String | Nil)
      query = %(SELECT #{new.attributes.keys.join(", ")} FROM #{table_name} WHERE id = id LIMIT 1;)
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      result = connection.exec(query)

      if result.rows.size > 0
        new(result.to_hash.first)
      else
        new
      end
    end

    def self.get_result_by(params)
      where = params.map {|key, val| %(#{table_name}.#{key} = '#{val}') }.join(" AND ")
      query = %(SELECT #{new.attributes.keys.join(", ")} FROM #{table_name} WHERE #{where} LIMIT 1;)
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      connection.exec(query)
    end
    
    def self.find_by(params)
      where = params.map {|key, val| %(#{table_name}.#{key} = '#{val}') }.join(" AND ")
      query = %(SELECT #{new.attributes.keys.join(", ")} FROM #{table_name} WHERE #{where} LIMIT 1;)      
      DB::LoggerDb.log(query.colorize(:light_gray).bold, :info, "Model")
      result = connection.exec(query)
      if result.rows.size > 0
        new(result.to_hash.first)
      else
        new
      end
    end
  end
end