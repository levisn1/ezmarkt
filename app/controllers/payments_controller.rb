class PaymentsController < ApplicationController
  before_action :set_order

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
      )

    charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @order.amount_cents,
    description:  "Payment for your products for order #{@order.id}",
    currency:     @order.amount.currency
    )

    @order.update(payment: charge.to_json, paid: true)
    respond_to do |format|
        format.html { redirect_to orders_path, notice: 'Payment Completed!' }
    end
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to orders_path
  end

  private

  def set_order
    @order = current_user.orders.where(paid: false).find(params[:order_id])
  end
end
