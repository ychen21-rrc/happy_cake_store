class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:categories).order(created_at: :desc)

    if params[:category_id].present?
      @products = @products.joins(:categories).where(categories: {id: params[:category_id]})
    end

    if params[:filter] == "new"
      @products = @products.where(is_new: true)
    elsif params[:filter] == "sale"
      @products = @products.where(is_on_sale: true)
    end

    if params[:q].present?
      keyword = "%#{params[:q]}%"
      @products = @products.where("name ILIKE ? OR description ILIKE ?", keyword, keyword)
    end

    @products = @products.page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
  end
end
