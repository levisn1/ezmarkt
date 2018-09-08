class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home # [ :home, :about ...]
  def home
  end
end
