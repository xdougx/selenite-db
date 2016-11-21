module Selenite
  module DB
    class LoggerDb

      SEVERITY = {
        debug: Logger::Severity::DEBUG,
        info: Logger::Severity::INFO,
        warn: Logger::Severity::WARN,
        error: Logger::Severity::ERROR,
        fatal: Logger::Severity::FATAL,
        unknown: Logger::Severity::UNKNOWN
      }

      # TODO: need to check if it will work properly
      LOGGER_PATH = "#{__DIR__}/log/selenite_db.log"

      def self.define_log
        if File.exists?(LOGGER_PATH)
          @@logger = Logger.new(File.open(LOGGER_PATH, "a+"))
        else
          @@logger = Logger.new(STDOUT)
        end
      end

      define_log

      def self.logger
        @@logger
      end

      def self.logger=(@@logger)
      end

      def self.log(message, level = :info, label = "")
        logger.log(severity.fetch(level), message, label)
      end

      def self.putsl(message, level = :info, label = "")
        logger.log(severity.fetch(level), message, label)
      end

    end
  end
end