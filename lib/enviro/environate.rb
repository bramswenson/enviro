module Enviro
  module Environate

    def self.included(base)
      base.class_eval do
        attr_accessor :environment, :configuration, :logger
      end
      base.send(:include, Enviro::Environment)
      base.send(:include, Enviro::Configuration)
      base.send(:include, Enviro::Logger)
    end

  end
end
