require 'spec_helper'

describe Enviro::Environment do
  before(:each) do
    Object.send(:remove_const, :TestEnviroEnvironment) if defined?(TestEnviroEnvironment)
    class TestEnviroEnvironment
      include Enviro::Environment
    end
  end

  it "should have the environment attribute set the default when no session ENV setting is set" do
    ENV['ENVIRO_ENV'] = nil
    ENV['ENVIRO_ENV'].should be_nil
    TestEnviroEnvironment.environment.should == :development
  end

  it "should have the environment attribute set the same as the session ENV setting" do
    ENV['ENVIRO_ENV'] = 'production'
    ENV['ENVIRO_ENV'].should == "production"
    TestEnviroEnvironment.environment.should == :production
  end

  it "should alias env to environment" do
    ENV['ENVIRO_ENV'] = nil
    ENV['ENVIRO_ENV'].should be_nil
    TestEnviroEnvironment.env.should == :development
  end

  it "should return true on env?(value) when value is environment" do
    ENV['ENVIRO_ENV'] = nil
    ENV['ENVIRO_ENV'].should be_nil
    TestEnviroEnvironment.env?('development').should be_true
  end

  it "should return false on env?(value) when value is not environment" do
    ENV['ENVIRO_ENV'] = nil
    ENV['ENVIRO_ENV'].should be_nil
    TestEnviroEnvironment.env?('production').should be_false
  end

  context "within Rails" do
    before(:each) do
      module Rails
        def self.env
          :production
        end
      end
    end

    after(:each) do
      Object.send(:remove_const, :Rails) if defined?(Rails)
    end

    it "should inherit the environment from Rails should it be loaded" do
      ENV['ENVIRO_ENV'] = nil
      ENV['ENVIRO_ENV'].should be_nil
      TestEnviroEnvironment.environment.should == :production
    end
  end
end
