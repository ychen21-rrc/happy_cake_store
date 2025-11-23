class CartsController < ApplicationController
  before_action :init_cart

  def show
    @items = Product.find(@cart.keys)
  end

  def add
    pid = params[:product_id].to_s
    @cart[pid] = (@cart[pid] || 0) + 1
    session[:cart] = @cart
    redirect_to cart_path, notice: "Added to cart!"
  end

  def update
    pid = params[:product_id].to_s
    qty = params[:quantity].to_i
    @cart[pid] = qty if qty > 0
    session[:cart] = @cart
    redirect_to cart_path, notice: "Quantity updated!"
  end

  def remove
    pid = params[:product_id].to_s
    @cart.delete(pid)
    session[:cart] = @cart
    redirect_to cart_path, alert: "Item removed!"
  end

  private
  def init_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end
end
