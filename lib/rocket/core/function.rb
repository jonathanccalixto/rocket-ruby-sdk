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
        unless data.respond_to?(:to_json) && data.respond_to?(:as_json)
          raise RocketException.new 'Please provide a array data'
        end

        to_normalize(data.as_json).to_json
      end

      def json_array(json)
        Rocket::Response.new json, to_denormalize(json.parsed_response)
      end

      def prepare_sdk_checkout
        self.resource_url = Rocket.production_url
      end

      def prepare_sdk_sandbox_checkout
        self.resource_url = Rocket.sandbox_url
      end

      def prepare_sdk_development_checkout
        self.resource_url = Rocket.development_url
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
        options = self.opts.merge(
          :body => self.data_send,
          :format => :json
        )

        curl_response = self.class.post uri, options

        raise curl_response.inspect if self.debug?

        self.return_data = curl_response

        true
      end

      private

      def to_normalize(data)
        case data
        when BigDecimal then
          data.to_f
        when Hash then
          data.dup.inject({}) do |hash, (key, value)|
            hash["#{key}".camelcase(:lower).to_sym] = to_normalize(value)
            hash
          end
        when Array then
          data.collect do |value|
            to_normalize(value)
          end
        else
          data
        end
      end

      def to_denormalize(data)
        case data
        when Float then
          BigDecimal.new data.to_s
        when Hash then
          data.dup.inject({}) do |hash, (key, value)|
            hash["#{key}".underscore.to_sym] = to_denormalize(value)
            hash
          end
        when Array then
          data.collect do |value|
            to_denormalize(value)
          end
        else
          data
        end
      end
    end
  end
end
