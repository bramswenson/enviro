require 'spec_helper'

describe Enviro::Environate do
  context "the extended class" do

    context "should respond to" do
      %w( environment configuration logger).each do |meth|
        it "#{meth}" do
          EnviroMe.should respond_to(meth.to_sym)
        end
      end
    end
  end

  context "the extended module" do

    context "should respond to" do
      %w( environment configuration logger).each do |meth|
        it "#{meth}" do
          EnviroModule.should respond_to(meth.to_sym)
        end
      end
    end
  end

end
