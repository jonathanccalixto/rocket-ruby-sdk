module Rocket
  module Invoice
    class InvoiceProduct
      attr_accessor :name, :description, :unity_price, :quantity

      def initialize
        self.name = ''
        self.description = ''
        self.unity_price = BigDecimal.new('0.0')
        self.quantity = BigDecimal.new('0.0')
      end
    end
  end
end
