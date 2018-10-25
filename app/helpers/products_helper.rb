module ProductsHelper

  def index_methods_partial
    if params[:term].present?
      @products = Product.where(:ordinable => true).order('created_at DESC').search_by_name_and_description(params[:term]).paginate page: params[:page], per_page: 6
      "products/index_partials/search_results_products"
    else
      @products = Product.where(:ordinable => true).order('created_at DESC').paginate page: params[:page], per_page: 27
      "products/index_partials/all_products"
    end
  end
end
