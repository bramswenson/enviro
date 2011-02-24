require "bundler/setup"
Bundler.require
require 'forwardable'

module Enviro
  autoload :Environment,   'enviro/environment'
  autoload :Configuration, 'enviro/configuration'
  autoload :Logger,        'enviro/logger'
  autoload :Environate,    'enviro/environate'
end
