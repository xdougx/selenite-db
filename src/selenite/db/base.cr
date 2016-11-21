module Selenite
  module DB
    class Base
      extend DB
      include Selenite::DB::Atributtor

      DBCONN = PG.connect(conn_str)

      def self.configuration
        @@configuration = Selenite::DB::Configuration.config
      end

      def self.connection
        DBCONN
      end

      def self.conn_str
        config = get_configuration
        base_string = "postgresql://#{config["host"]}:#{config["port"]}/#{config["database"]}?"
        
        config_array = config.map do |key, value|
          unless key.to_s.match(/(host|port|database)/)
            if(value != "" && value != nil)
              "#{key}=#{value}"
            end
          end
        end.compact

        base_string + config_array.join("&")
      end

      def self.get_configuration
        config = configuration_by_env
        
        base_configuration.each do |key, value|
          unless config.keys.includes?(key)
            config[key] = value
          end
        end

        config
      end

      def self.base_configuration
        {
          "client_encoding" => "utf8",
          "port" => "5432",
          "database" => "default",
          "user" => "root",
          "password" => "",
          "host" => "localhost"
        }
      end

      def self.configuration_by_env
        data[env].as(Hash)
      end 

      def self.data
        # TODO: Setup the path with a configuration
        path = "#{root}/config/database.yml"
        
        if File.exists?(path)
          YAML.parse(File.read(path))
        else
          base_configuration
        end
      end
    end
  end
end