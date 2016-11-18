require "colorize"
require "logger"
require "yaml"
require "json"

require "./selenite-db/*"

module Selenite
  module DB

  def env
    APPLICATION_ENV
  end

  def root
    ROOT
  end

  def files_path
    "#{root}/files"
  end

  end
end
