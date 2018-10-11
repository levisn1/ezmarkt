class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products_search = Product.where(:ordinable => true).search_by_name_and_description(params[:term]).paginate page: params[:page], per_page: 20
    @products = Product.where(:ordinable => true).paginate page: params[:page], per_page: 20

  end


  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

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

  def update
    @product.update(product_params)
    respond_to do |format|
      format.html { redirect_to product_path, notice: 'The product was successfully updated.' }
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'The product was successfully destroyed.' }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :category_id, :price, :picture, :picture_cache)
    end
  end
