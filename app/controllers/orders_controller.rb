class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @order = Order.find_by user_id: current_user.id
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    #@product = Product.find(params[:id])
    #@order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    if current_user.orders.present?
      @product = Product.find(params[:id])
      @order = current_user.orders.first
      order_id = @order.id
      product_id = @product.id
      @product.ordinable = false
      @product.save
      if @order.products << @product
        respond_to do |format|
          format.html { redirect_to orders_path, notice: 'Product added to the cart!' }
        end
      else
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'There was a problem while adding the product to the cart!' }
        end
      end
    else
      @product = Product.find(params[:id])
      product_id = @product.id
      @order = current_user.orders.new
      @order.save
      order_id = @order.id
      @product.ordinable = false
      @product.save
      if @order.products << @product
        respond_to do |format|
          format.html { redirect_to orders_path, notice: 'Product added to the cart!' }
        end
      OrderPaidCheckJob.set(wait: 25.minutes).perform_later(order_id)
      else
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'There was a problem with your order!' }
        end
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def order_params
      #params.require(:order).permit(:product_id)
    #end
end
