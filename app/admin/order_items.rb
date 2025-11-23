ActiveAdmin.register OrderItem do
  actions :index, :show

  filter :order_id
  filter :product_name, as: :string

  index do
    id_column
    column :order
    column :product
    column :quantity
    column("Price at Purchase") { |i| number_to_currency(i.price_at_purchase) }
    column("Line Total") { |i| number_to_currency(i.price_at_purchase * i.quantity) }
    actions
  end
end
