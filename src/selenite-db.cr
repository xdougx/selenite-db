require "colorize"
require "logger"
require "yaml"
require "json"
require "pg"

require "./selenite/db/*"

module Selenite
  module DB

    SELENITE_ENV = { env }.call()
    SELENITE_ROOT = __DIR__

    def env
      # TODO something to get the current env
      "development"
    end

    def root
      SELENITE_ROOT
    end
  end
end
