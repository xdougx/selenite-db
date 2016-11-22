module Selenite
  module DB
    class Configuration
      
      @client_encoding : String
      @port : String
      @database : String
      @user : String
      @password : String
      @host : String
      @env : String

      property(client_encoding, port, database, user, password, host, env)

      def initialize
        @client_encoding = "utf8"
        @port = "5432"
        @database = "default"
        @user = "root"
        @password = ""
        @host = "localhost"
        @env = "development"
      end

      def as_hash
        {
          "client_encoding" => @client_encoding,
          "port" => @port,
          "database" => @database,
          "user" => @user,
          "password" => @password,
          "host" => @host,
        }
      end

    end
  end
end