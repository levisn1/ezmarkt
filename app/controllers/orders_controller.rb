class OrdersController < ApplicationController
  before_action :set_product, only: [:create, :update]
  before_action :set_order_payment, only: [:payorder, :index, :destroy, :update, :product_ordinable]
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
    redirect_to orders_path
  end

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if current_user.orders.where(paid: false).present?
      order = current_user.orders.last
      order_id = order.id
      product_id = @product.id
      @product.ordinable = false
      @product.save
      order_amount = order.amount
      if order.products << @product
        order.products.each do |x|
        @order_amountnew = order_amount + x.price
        end
        order.amount = @order_amountnew
        order.save
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'Product added to the cart!' }
        end
      else
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'There was a problem while adding the product to the cart!' }
        end
    end
    else
      product_id = @product.id
      order = current_user.orders.new
      order.save
      order_id = order.id
      @product.ordinable = false
      @product.save
      order_amount = order.amount
      if order.products << @product
        order.products.each do |x|
        @order_amountnew = order_amount + x.price
        end
        order.amount = @order_amountnew
        order.save
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'Product added to the cart!' }
        end
      OrderPaidCheckJob.set(wait: 3.minutes).perform_later(order_id)
      else
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'There was a problem with your order!' }
        end
      end
    end
  end

  def update
    @order.products.delete(Product.find(@product.id))
    @product.ordinable = true
    @product.save
    @order.amount = 0
    @order.save
    @order_amountnew = @order.amount
    @order.products.each do |x|
    @order_amountnew = @order_amountnew + x.price
      end
    @order.amount = @order_amountnew
    @order.save
    if @order.products.empty?
      @order.destroy
    end
    redirect_to orders_url
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end


  private

    def set_product
       @product = Product.find(params[:id])
    end

    def set_order_payment
      @order = current_user.orders.last
    end

    def product_ordinable
    @order.products.each do |x|
      x.ordinable = true
      x.save
    end
  end
end
