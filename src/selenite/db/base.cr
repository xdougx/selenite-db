module Selenite
  module DB
    class Base
      extend DB
      include Selenite::DB::Atributtor

      @@connection : PG::Connection?
      @@config : Selenite::DB::Configuration?
      @@pool : ConnectionPool(PG)?

      def self.configure(&block)
        @@config = Selenite::DB::Configuration.new
        yield(@@config)
      end

      def self.exec(query)
        result = nil
        @@pool.connection do |conn|
          result = conn.exec(query)
        end
        result
      end

      def self.config
        @@config
      end

      def self.connection
        @@pool = ConnectionPool(PG).new(capacity: 25, timeout: 0.01) do
          PG.connect(conn_str)
        end
      end

      def self.conn_str
        base_string = "postgresql://#{@@config.host}:#{@@config.port}/#{@@config.database}?"
        
        config_array = @@config.as_hash.map do |key, value|
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