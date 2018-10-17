class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end


  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    if @product = current_user.products.create!(product_params)
      redirect_to products_path, notice: 'The product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path, notice: 'The product was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'The product was successfully destroyed.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :category_id, :price, :picture, :picture_cache)
    end
  end
