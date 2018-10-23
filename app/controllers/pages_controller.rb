class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @products = Product.all
    @productsample = Product.where(:ordinable => true).last(12).shuffle
  end
end
