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
  @user = current_user
  @userid = current_user.id
  @product = Product.find(params[:id])
  #if @user.order.first != nil
    #@order = @user.order.first
    #@order.products << @product
    #@order.users << @userid
    #@order.save
    #redirect_to products_path
  #else
    #@user = current_user
    #@product = Product.find(params[:id])
    @order = @user.order.new
      @order << userid
      @order.products << @product.id
      @order.users << @userid
      @order.save
      byebug
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'Order was created.' }
      end
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'Order wasn''t created.' }
      end
    #end
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
