module DB
  class Base
    extend DB

    DBCONN = PG.connect(conn_str)

    # get the current env
    def self.env
      APPLICATION_ENV
    end

    def self.connection
      DBCONN
    end

    def self.conn_str
      config = configuration
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

    protected def self.configuration
      config = configuration_by_env
      base_configuration.each { |key, value| config[key] = value unless config.keys.includes?(key) }
      config
    end

    protected def self.base_configuration
      {
        "client_encoding" => "utf8",
        "port" => "5432",
        "database" => "default",
        "user" => "root",
        "password" => "",
        "host" => "localhost"
      }
    end

    protected def self.configuration_by_env
      data[env] as Hash
    end

    protected def self.data
      YAML.load(File.read("#{root}/config/database.yml")) as Hash
    end
  end
end
