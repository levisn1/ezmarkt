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
    @product = current_user.products.new(product_params)
    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'The product was successfully created.' }
      end
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      respond_to do |format|
        format.html { redirect_to product_path, notice: 'The product was successfully updated.' }
      end
    else
      render :new
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
