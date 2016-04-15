module Rocket
  module Payment
    class Transfer < Rocket::Core::Function
      def initialize(token, env = :production, debug = false)
        super(debug)

        raise RocketException.new "Please Provide a Valid Token" if token.blank?

        self.token = token

        case env.to_sym
        when :production then self.prepare_sdk_checkout
        when :sandbox then self.prepare_sdk_sandbox_checkout
        else self.prepare_sdk_development_checkout
        end
      end

      def check_user(email)
        self.method_send = "checkout/user/check/token/#{self.token}"
        self.data_send = self.make_json(:emailUser => email)
        self.curl_send

        retorno = self.json_array(self.return_data)

        raise RocketException.new retorno.message unless retorno.success

        self.status = retorno

        retorno
      end

      def check_balance(account = 'default')
        self.method_send = "checkout/user/check-balance/token/#{self.token}"
        self.data_send = self.make_json(:account => account)
        self.curl_send

        retorno = self.json_array(self.return_data)

        raise RocketException.new retorno.message unless retorno.success

        self.status = retorno

        retorno
      end

      def send_transfer(user, value, currency = 'USD', description = '')
        self.send_method = "checkout/user/send-transfer/token/#{self.token}"
        self.data_send = self.make_json(
          :userTo => user, :value => value, :description => description,
          :currency => currency
        )
        self.curl_send

        retorno = self.json_array(self.return_data)

        raise RocketException.new retorno.message unless retorno.success

        self.status = retorno

        retorno
      end

      private

      attr_accessor :status
    end
  end
end
