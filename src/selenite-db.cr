require "colorize"
require "logger"
require "yaml"
require "json"
require "pg"
require "pool/connection"

alias BaseValues = Int32 | Int64 | String | ::Nil
alias Uuid = (Array(Bool | Nil) | Array(Bool) | Array(Char | Nil) | Array(Char) | Array(Float32 | Nil) | Array(Float32) | Array(Float64 | Nil) | Array(Float64) | Array(Int16 | Nil) | Array(Int16) | Array(Int32 | Nil) | Array(Int32) | Array(Int64 | Nil) | Array(Int64) | Array(PG::BoolArray) | Array(PG::CharArray) | Array(PG::Float32Array) | Array(PG::Float64Array) | Array(PG::Geo::Point) | Array(PG::Int16Array) | Array(PG::Int32Array) | Array(PG::Int64Array) | Array(PG::StringArray) | Array(String | Nil) | Array(String) | Bool | Char | Float32 | Float64 | Int16 | Int32 | Int64 | JSON::Any | PG::Geo::Box | PG::Geo::Circle | PG::Geo::Line | PG::Geo::LineSegment | PG::Geo::Path | PG::Geo::Point | PG::Numeric | Slice(UInt8) | String | Time | UInt32 | Nil)

require "./selenite/db/*"

module Selenite
  module DB

    SELENITE_ENV = { env }.call()
    SELENITE_ROOT = __DIR__


    def env
      "development"
    end

    def root
      SELENITE_ROOT
    end

  end
end





pg = ConnectionPool.new(capacity: 25, timeout: 0.01) do
  PG.connect(ENV["DATABASE_URL"])
end