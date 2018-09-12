class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
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
    @product = Product.find(params[:id])
    @order = current_user.orders.new
    if @order.save
      @order.products << @product
      #byebug
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'Order was successfully created.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'Order was not created.' }
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
