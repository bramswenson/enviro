require 'spec_helper'

describe Enviro::Logger do
  context "with standard environment variable" do
    before(:each) do
      Object.send(:remove_const, :TestEnviroLogger) if defined?(TestEnviroLogger)
      class TestEnviroLogger
        include Enviro::Environment
        include Enviro::Logger
      end
      ENV['ENVY_LOG_DIR'] = nil
      ENV['ENVY_CONF_PATH'] = nil
      ENV['ENVY_ENV'] = nil
    end

    it "should have logger like object available" do
      TestEnviroLogger.logger.should respond_to(:debug)
    end

    it "should log to STDOUT if ENVY_LOG_DIR is nil" do
      TestEnviroLogger.logger.instance_variable_get(:@logdev).dev.should be(STDOUT)
    end

    it "should log to /tmp/development.log if ENVY_LOG_DIR is /tmp and ENVY_ENV is development" do
      ENV['ENVY_LOG_DIR'] = '/tmp'
      TestEnviroLogger.logger.instance_variable_get(:@logdev).dev.path.should == '/tmp/development.log'
    end

    %w( debug error fatal info warn ).each do |level|
      it "should allow logging to level #{level}" do
        expect { TestEnviroLogger.send(level.to_sym, 'test') }.should_not raise_error
      end
    end

    it "should raise when log file is not writable" do
      ENV['ENVY_LOG_DIR'] = '/tmp/this_dir_is_not_here'
      expect {
        TestEnviroLogger.logger
      }.should raise_error(Enviro::Logger::DirectoryNotFound)
    end

    context "within Rails" do
      before(:each) do
        module ::Rails
          def self.logger
            ::Logger.new(STDOUT)
          end
        end
      end

      after(:each) do
        Object.send(:remove_const, :Rails) if defined?(Rails)
      end

      it "should inherit the logger from Rails should it be loaded" do
        # if we set the log dir to something that doesn't exist 
        # we can more sure that the Rails.logger is getting used
        # since otherwise we would raise an error due to the missing dir
        ENV['ENVY_LOG_DIR'] = '/tmp/this_should_not_exits'
        TestEnviroLogger.logger.instance_variable_get(:@logdev).dev.should == Rails.logger.instance_variable_get(:@logdev).dev
      end
    end
  end
  context "with custom environment variable" do
    before(:each) do
      Object.send(:remove_const, :TestEnviroLogger) if defined?(TestEnviroLogger)
      ENV['CUSTOM_LOG'] = '/tmp'
      class TestEnviroLogger
        include Enviro::Environment
        include Enviro::Logger
        logger_dir_env :custom_log
      end
      ENV['ENVY_LOG_DIR'] = nil
      ENV['ENVY_CONF_PATH'] = nil
      ENV['ENVY_ENV'] = nil
    end

    it "should upcase the logger_dir_env attribute" do
      TestEnviroLogger.logger_dir_env.should == 'CUSTOM_LOG'
    end

  end
end
