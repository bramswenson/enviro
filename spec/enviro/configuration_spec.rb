require 'spec_helper'

describe Enviro::Configuration do
  context "with standard environment variable" do
    before(:each) do
      Object.send(:remove_const, :TestEnviroConfiguration) if defined?(TestEnviroConfiguration)
      ENV['ENVY_CONF_PATH'] = '/tmp/enviro.yml'
      class TestEnviroConfiguration
        include Enviro::Environment
        include Enviro::Configuration
      end
      config = {
        :development => {
        },
        :test => {
        },
        :production => {
        },
      }
      File.open(ENV['ENVY_CONF_PATH'], 'w') do |f|
        f.write(YAML.dump(config))
      end
    end

    it "should have configuration available as a struct like object" do
      TestEnviroConfiguration.configuration.should respond_to(:methods)
    end

    it "should have configuration for current environment" do
      TestEnviroConfiguration.configuration.environment.should be(:development)
    end

    it "should raise when configuration file is not found" do
      ENV['ENVY_CONF_PATH'] = 'who_the_heck_knows'
      expect {
        TestEnviroConfiguration.configuration
      }.should raise_error(Enviro::Configuration::FileNotFound)
    end

    it "should raise when configuration for current environment is not found" do
      ENV['ENVY_ENV'] = 'who_the_heck_knows'
      expect {
        TestEnviroConfiguration.configuration.environment
      }.should raise_error(Enviro::Configuration::UnknownEnvironment)
    end
  end

  context "with custom environment variable" do
    before(:each) do
      Object.send(:remove_const, :TestEnviroConfiguration) if defined?(TestEnviroConfiguration)
      ENV['CUSTOM_PATH'] = '/tmp/enviro_custom.yml'
      class TestEnviroConfiguration
        include Enviro::Environment
        include Enviro::Configuration
        configuration_path_env :custom_path
      end
      config = {
        :development => {
        },
        :test => {
        },
        :production => {
        },
      }
      File.open(ENV['CUSTOM_PATH'], 'w') do |f|
        f.write(YAML.dump(config))
      end
    end

    it "should upcase the configuration_path_env attribute" do
      TestEnviroConfiguration.configuration_path_env.should == 'CUSTOM_PATH'
    end

  end
end
