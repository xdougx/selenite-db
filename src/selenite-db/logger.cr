require "logger"

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

    @@logger = Logger.new(File.open("#{_DIR_}/log/selenite_db.log", "a+"))

    def self.logger
      @@logger
    end

    def self.logger=(@@logger)
    end

    def self.log(message, level: :info, label = "")
      logger.log(severity.fetch(level), message, label)
    end


    def self.putsl(message, level = :info, label = "")
      logger.log(severity.fetch(level), message, label)
    end

  end
end