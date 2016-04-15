module Rocket
  module Checkout
    class Checkout < Rocket::Core::Function
      attr_accessor :invoice_token, :pay_invoice_url, :client_pass
      attr_accessor :invoice_status, :merchant_id

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

      def create_invoice(invoice)
        unless invoice.is_a?(Rocket::Invoice::Invoice)
          raise RocketException.new "Invalid Invoice Data"
        end

        self.data_send = self.make_json(invoice)
        self.method_send = "put-invoice/#{self.token}"
        self.curl_send
        retorno = self.json_array(self.return_data)

        raise RocketException.new retorno.message unless retorno.success

        self.invoice_token = retorno.invoiceCode
        self.client_pass = false
        self.invoice_token = retorno.returnUrl

        if retorno.user && retorno.user.new.blank?
          self.client_pass = retorno.user.userPassword
        end

        retorno
      end

      def check_invoice(invoice)
        self.data_send = self.make_json(:invoice => invoice)
        self.method_send = "checkout/invoice/query/token/#{token}"
        self.curl_send

        retorno = self.json_array(self.return_data)

        raise RocketException.new retorno.message unless retorno.success

        self.invoice_status = retorno.invoiceStatus
        self.invoice_token = retorno.invoice_id
        self.merchant_id = retorno.merchantId

        retorno
      end
    end
  end
end
