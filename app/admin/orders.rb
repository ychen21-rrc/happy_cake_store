ActiveAdmin.register Order do
  permit_params :status

  actions :all, except: [:new, :create, :destroy]

  scope :all, default: true
  scope("Paid")   { |s| s.where(status: "paid") }
  scope("Pending"){ |s| s.where(status: "pending") }
  scope("Shipped"){ |s| s.where(status: "shipped") }
  scope("Cancelled"){ |s| s.where(status: "cancelled") }

  filter :id
  filter :user_email, as: :string
  filter :status, as: :select, collection: %w[pending paid shipped cancelled]
  filter :created_at

  index do
    selectable_column
    id_column
    column :user do |o|
      o.user&.email
    end
    column :status
    column("Subtotal") { |o| number_to_currency(o.subtotal) }
    column("GST")      { |o| number_to_currency(o.gst_amount) }
    column("PST")      { |o| number_to_currency(o.pst_amount) }
    column("HST")      { |o| number_to_currency(o.hst_amount) }
    column("Total")    { |o| number_to_currency(o.total_price) }
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :status
      row :created_at
      row :user do |o|
        o.user&.email
      end

      row :address do |o|
        a = o.address
        if a
          "#{a.street}, #{a.city}, #{a.province&.name}, #{a.postal_code}"
        else
          "No address"
        end
      end

      row("Subtotal") { number_to_currency(order.subtotal) }
      row("GST")      { number_to_currency(order.gst_amount) }
      row("PST")      { number_to_currency(order.pst_amount) }
      row("HST")      { number_to_currency(order.hst_amount) }
      row("Total")    { number_to_currency(order.total_price) }
    end

    panel "Order Items" do
      table_for order.order_items.includes(:product) do
        column("Product") { |item| item.product&.name }
        column :quantity
        column("Price at Purchase") { |item| number_to_currency(item.price_at_purchase) }
        column("Line Total") { |item| number_to_currency(item.price_at_purchase * item.quantity) }
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Update Status" do
      f.input :status, as: :select, collection: %w[pending paid shipped cancelled]
    end
    f.actions
  end
end
