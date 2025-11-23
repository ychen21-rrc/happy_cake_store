class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :init_cart

  def new
    @address = current_user.address || current_user.build_address
    @provinces = Province.all
    @items = Product.find(@cart.keys)
  end

  def create
    @address = current_user.address || current_user.build_address
    @address.assign_attributes(address_params)
    @provinces = Province.all

    unless @address.save
      @items = Product.find(@cart.keys)
      return render :new, status: :unprocessable_entity
    end

    items = Product.find(@cart.keys)
    subtotal = items.sum { |p| p.price * @cart[p.id.to_s] }

    prov = @address.province
    gst_amount = subtotal * prov.gst
    pst_amount = subtotal * prov.pst
    hst_amount = subtotal * prov.hst
    total = subtotal + gst_amount + pst_amount + hst_amount

    order = current_user.orders.create!(
      address: @address,
      status: "paid",
      subtotal: subtotal,
      gst_amount: gst_amount,
      pst_amount: pst_amount,
      hst_amount: hst_amount,
      total_price: total
    )

    items.each do |p|
      order.order_items.create!(
        product: p,
        quantity: @cart[p.id.to_s],
        price_at_purchase: p.price
      )
    end

    session[:cart] = {}
    redirect_to order_path(order), notice: "Order placed!"
  end

  private
  def init_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def address_params
    params.require(:address).permit(:street, :city, :province_id, :postal_code)
  end
end
