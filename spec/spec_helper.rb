require 'bundler/setup'
Bundler.require(:default, :development)

class EnviroMe
  include Enviro::Environate
end

module EnviroModule
  include Enviro::Environate
end
