class OrderPaidCheckJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    if order.paid == false
      order.products.each do |x|
        x.ordinable = true
        x.save
      end
      order.destroy
    end
  end
end
