module Rocket
  module Subscription
    class Plan < Rocket::Core::Function
      protected

      attr_accessor :plan_id, :plan_name
    end
  end
end
