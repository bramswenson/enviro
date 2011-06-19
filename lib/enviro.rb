require 'forwardable'
require 'ostruct'
require 'core_ext/hash'

module Enviro
  autoload :Environment,   'enviro/environment'
  autoload :Configuration, 'enviro/configuration'
  autoload :Logger,        'enviro/logger'
  autoload :Environate,    'enviro/environate'
end
