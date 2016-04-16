require "httparty"
require "recursive-open-struct"
require "active_support/all"

require "rocket/ruby/sdk/version"

require 'rocket/response'
require 'rocket/core'
require 'rocket/checkout'
require 'rocket/invoice'
require 'rocket/payment'
require 'rocket/subscription'
require 'rocket/system'

module Rocket
  mattr_accessor :production_url
  @@production_url = "http://dashboard.rocketpays.com"

  mattr_accessor :sandbox_url
  @@sandbox_url = "http://dashboard.sandbox.rocketpays.com"

  mattr_accessor :development_url
  @@development_url = "http://dashboard.rocketpays.dev"

  mattr_accessor :environment
  @@environment = :production

  def self.setup
    yield self
    nil
  end
end

class RocketException < Exception
end
