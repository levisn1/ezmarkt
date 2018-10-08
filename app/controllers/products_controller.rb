class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products_search = Product.where(:ordinable => true).search_by_name_and_description(params[:term]).paginate page: params[:page], per_page: 20
    #@products = Product.all
    @products = Product.where(:ordinable => true).paginate page: params[:page], per_page: 20

  end

  # GET /products/1
  # GET /products/1.json
  def show
    #@product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    #@product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.new(product_params)
    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'The product was successfully created.' }
      end
    else
      redirect_to new_product_path
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    #@product = Product.find(params[:id])
    @product.update(product_params)
    respond_to do |format|
      format.html { redirect_to product_path, notice: 'The product was successfully updated.' }
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    #@product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'The product was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :tagline, :description, :category_id, :price)
    end
  end
