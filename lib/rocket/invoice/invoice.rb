module Rocket
  module Invoice
    class Invoice
      attr_accessor :invoice_number, :invoice_description, :invoice_currency
      attr_accessor :customer_name, :customer_email, :invoice_discounts
      attr_accessor :invoice_delivery_fee, :success_url, :cancel_url
      attr_accessor :invoice_products

      def initialize
        self.invoice_currency = 'USD'
        self.invoice_discounts = BigDecimal.new('0.0')
        self.invoice_delivery_fee = BigDecimal.new('0.0')
        self.invoice_products = []
      end

      def add_products(product)
        unless product.is_a? InvoiceProduct
          raise RocketException.new 'Invalid Product Class'
        end

        self.invoice_products << product

        true
      end
    end
  end
end
