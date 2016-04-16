# Rocket::Ruby::Sdk

Ruby SDK to Rocket API, with this SDK you can create invoices and retrieve invoice status from out Simple Checkout System, you can make API calls when your plan have it.
This gem is based at [SDK PHP](https://github.com/Rocket-System/php-sdk)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rocket-ruby-sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rocket-ruby-sdk

## Usage

### Send a new order:
``` ruby
checkout = Rocket::Checkout::Checkout.new 'INFORM YOU SIMPLE CHECKOUT KEY'

invoice = Rocket::Invoice::Invoice.new
invoice.invoice_number = 1
invoice.invoice_description = 'Test Description'
invoice.cancel_url = 'http://example.com/cancel'
invoice.success_url = 'http://example.com/success'
invoice.customer_email = 'john@doe.com'
invoice.customer_name = 'John Doe'

product = Rocket::Invoice::InvoiceProduct.new
product.name = 'Test Product'
product.description = "Test Product Description"
product.quantity = 10
product.unity_price = BigDecimal.new('9.90')

product2 = Rocket::Invoice::InvoiceProduct.new
product2.name= "Test Product"
product2.description = "Test Product Description"
product2.quantity = 1
product2.unity_price = BigDecimal.new('1000.00')

invoice.add_products(product)
invoice.add_products(product2)

checkout.create_invoice(invoice)

return_url = checkout.pay_invoice_url
invoice_unique_code = checkout.invoice_token
status = checkout.invoice_status
```

### Query an order:

``` ruby
checkout = Rocket::Checkout::Checkout.new 'INFORM YOU SIMPLE CHECKOUT KEY'
invoice = checkout.check_invoice 'INVOICE UNIQUE ID'
status = checkout.invoice_status
```

### Check if a user exists:

``` ruby
transfer = Rocket::Payment::Transfer.new 'INFORM YOU SIMPLE CHECKOUT KEY'
send = transfer.check_user 'user@email.com'
send.status
```

### Get your actual Balance

You can check your actual balance for all your accounts:

default = Your default money account
bitcoin = You bitcoin Wallet
blocked = Your blocked funds wallet

``` ruby
transfer = Rocket::Payment::Transfer.new 'INFORM YOU SIMPLE CHECKOUT KEY'
send = $transfer.check_balance 'default'
send.status
```

### Transfer Money:

``` ruby
transfer = Rocket::Payment::Transfer.new 'INFORM YOU SIMPLE CHECKOUT KEY'
send = transfer.send_transfer 'user@email.com', BigDecimal.new('20.00'), 'USD',
  'Your Custom Message'
send.status
```

## Known issues

* Cover the gem with tests (I believe not something from another world)
* Improve DSL SDK (It was based on a [php code](https://github.com/Rocket-System/php-sdk))

So  ...


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jonathanccalixto/rocket-ruby-sdk.

