module Selenite
  module DB
    class Base
      extend DB
      include Selenite::DB::Atributtor

      @@config : Selenite::DB::Configuration
      @@config = Selenite::DB::Configuration.get_configuration
      @@pool : ConnectionPool(PG::Connection)?

      def self.config
        @@config ||= Selenite::DB::Configuration.get_configuration
      end

      def self.pool
        @@pool ||= ConnectionPool(PG::Connection).new(capacity: 25, timeout: 0.01) do
          PG.connect(conn_str)
        end
      end

      def self.exec(query)
        conn = self.pool.checkout
        result = conn.exec(query)
        self.pool.checkin(conn)
        result
      end

      def exec(query)
        self.class.exec(query)
      end

      def self.conn_str
        base_string = "postgresql://#{self.config.host}:#{self.config.port}/#{self.config.database}?"
        
        config_array = self.config.as_hash.map do |key, value|
          unless key.to_s.match(/(host|port|database)/)
            if(value != "" && value != nil)
              "#{key}=#{value}"
            end
          end
        end.compact

        base_string + config_array.join("&")
      end
    end
  end
end
