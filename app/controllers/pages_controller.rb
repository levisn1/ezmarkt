class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home # [ :home, :about ...]
  def home
    @products = Product.all
  end
end
