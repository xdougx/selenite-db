module Selenite
  module DB
    class Configuration
      extend DB

      @@configuration

      def setup(&block)
        yield
      end
    end
  end
end