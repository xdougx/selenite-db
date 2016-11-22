module Selenite
  module DB
    class LoggerDb

      SEVERITY = {
        "debug" => Logger::Severity::DEBUG,
        "info" => Logger::Severity::INFO,
        "warn" => Logger::Severity::WARN,
        "error" => Logger::Severity::ERROR,
        "fatal" => Logger::Severity::FATAL,
        "unknown" => Logger::Severity::UNKNOWN
      }

      # TODO: need to check if it will work properly
      LOGGER_PATH = "#{__DIR__}/log/selenite_db.log"
      @@logger : Logger
      @@logger = Logger.new(get_logger_type)

      def self.get_logger_type
        if File.exists?(LOGGER_PATH)
          File.open(LOGGER_PATH, "a+")
        else
          STDOUT
        end
      end

      def self.logger
        @@logger
      end

      def self.logger=(@@logger)
      end

      def self.log(message, level = :info, label = "")
        @@logger.log(SEVERITY.fetch(level), message, label)
      end

      def self.putsl(message, level = :info, label = "")
        @@logger.log(SEVERITY.fetch(level), message, label)
      end

    end
  end
end