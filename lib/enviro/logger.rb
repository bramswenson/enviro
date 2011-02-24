module Enviro
  module Logger

    class DirectoryNotFound < StandardError; end

    def self.included(base)
      base.send(:extend, ClassMethods)
      base.instance_eval do
        class << self
          extend Forwardable
          def_delegators :logger, :debug, :error, :fatal, :info, :warn
        end
      end
    end

    module ClassMethods

      def logger_dir_env(value=nil)
        @_logger_dir_env ||= 'ENVY_LOG_DIR'
        @_logger_dir_env = value.to_s.upcase unless value.nil?
        @_logger_dir_env
      end

      def logger_dir
        @_logger_dir ||= ENV[self.logger_dir_env]
      end

      def logger
        @_logger ||= _setup_logger_for_environment
      end

      private

        def _setup_logger_for_environment
          return ::Rails.logger if defined?(::Rails)
          unless self.logger_dir.nil?
            raise DirectoryNotFound unless File::directory?(self.logger_dir)
            @logger_path = File.join(self.logger_dir, "#{self.environment}.log")
          else
            @logger_path = STDOUT
          end
          require 'logger'
          return ::Logger.new(@logger_path)
        end
    end

  end
end

