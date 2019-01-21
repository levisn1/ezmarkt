class OrderPaidCheckJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    return if order.nil? || order.paid
    if order.updated_at > 2.minutes.ago # order recently changed
      OrderPaidCheckJob.set(wait: 2.minutes).perform_later(order.id)
      return # end this job. check again 10min later
    end
    order.products.each do |x|
      x.ordinable = true
      x.save
    end
    order.destroy
  end
end
