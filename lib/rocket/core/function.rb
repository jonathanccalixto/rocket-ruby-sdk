require 'httparty'

module Rocket
  module Core
    class Function
      include HTTParty

      attr_accessor :debug

      def initialize(debug = false)
        self.debug = debug
      end

      def debug?
        !!self.debug
      end

      protected

      attr_accessor :resource_url, :token, :data_send, :return_data, :method_send

      def method_send=(method)
        @method_send = "/#{method}"
      end

      def make_json(data)
        raise RocketException.new 'Please provide a array data' unless data.is_a?(Array)

        data.to_json
      end

      def json_array(json)
        JSON.parse json
      end

      def prepare_sdk_checkout
        self.resource_url = 'https://dashboard.rocketpays.com'
      end

      def prepare_sdk_sandbox_checkout
        self.resource_url = 'http://dashboard.sandbox.rocketpays.com'
      end

      def prepare_sdk_development_checkout
        self.resource_url = 'http://dashboard.rocketpays.dev'
      end

      def send_request(to)
        true
      end

      def opts
        @opts ||= {}
        @opts[:headers] ||= {}

        @opts[:headers].merge!(
          {
            #"Content-Type" => "application/json",
            "token" => self.token
          }
        )

        @opts
      end

      def curl_send
        uri = "#{self.resource_url}#{self.method_send}"
        options = self.opts.merge(:body => self.data_send)

        curl_response = self.class.post uri, options

        raise curl_response.inspect if self.debug?

        self.return_data = curl_response

        true
      end
    end
  end
end
