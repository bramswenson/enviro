module Enviro
  module Configuration

    class FileNotFound < StandardError; end
    class UnknownEnvironment < StandardError; end

    def self.included(base)
      base.send(:extend,  ClassMethods)
    end

    module ClassMethods

      def configuration_path_env(value=nil)
        @_configuration_path_env ||= 'ENVY_CONF_PATH'
        @_configuration_path_env = value.to_s.upcase unless value.nil?
        @_configuration_path_env
      end

      def configuration_path
        @_configuration_path ||= (ENV[self.configuration_path_env]||'enviro.yml')
      end

      def configuration
        @_configuration ||= _load_configuration_path
      end

      private

        def _load_configuration_path
          raise FileNotFound.new(self.configuration_path) unless
            File.exists?(self.configuration_path)

          @raw_configuration = YAML.load_file(self.configuration_path)

          raise UnknownEnvironment.new(self.environment) unless
            @raw_configuration.key?(self.environment)

          OpenStruct.new(@raw_configuration[self.environment].merge(:environment => self.environment))
        end

    end
  end
end

