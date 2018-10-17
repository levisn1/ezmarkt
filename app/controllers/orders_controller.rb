class OrdersController < ApplicationController
  before_action :set_product, only: [:create, :update]
  before_action :set_order, only: [:payorder, :index, :destroy, :update, :product_ordinable]
  before_action :product_ordinable, only: [:destroy]

  def payorder
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
      )

    charge = Stripe::Charge.create(
      customer:     customer.id,
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
    render :index
  end

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  delegate *%w(
  unpaid_orders?
  orders
  ), to: :current_user

  def create
    order = unpaid_orders? ? orders.last : orders.create!
    @product.update(ordinable: false)
    if order.products << @product
      order.update(amount: order.products.sum(&:price))
      @notice = 'Product added to the Cart!'
      OrderPaidCheckJob.set(wait: 3.minutes).perform_later(order.id) unless unpaid_orders?
    else
      @notice = 'There was a problem while adding the product to the cart!'
    end
    redirect_to products_path, notice: @notice
  end

  def update
    @order.products.delete(Product.find(@product.id))
    @product.update(ordinable: true)
    if @order.products.empty?
      @order.destroy
      @notice = 'Order deleted!'
    else
      @order.update(amount: @order.products.sum(&:price))
      @notice = 'Order Updated!'
    end
    redirect_to orders_path, notice: @notice
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'The order was successfully destroyed.'
  end

  private

  def set_product
   @product = Product.find(params[:id])
  end

 def set_order
  @order = current_user.orders.last
  end

  def product_ordinable
    @order.products.each do |x|
      x.ordinable = true
      x.save
    end
  end
end
