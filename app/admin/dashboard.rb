ActiveAdmin.register_page "Dashboard" do
  content do
    columns do
      column do
        panel "Store Overview" do
          div class: "d-flex flex-wrap gap-3" do
            div class: "badge bg-primary p-3 fs-6" do
              "Products: #{Product.count}"
            end
            div class: "badge bg-success p-3 fs-6" do
              "Orders: #{Order.count}"
            end
            div class: "badge bg-warning text-dark p-3 fs-6" do
              "Users: #{User.count}"
            end
            div class: "badge bg-danger p-3 fs-6" do
              revenue = Order.sum(:total_price)
              "Revenue: #{number_to_currency(revenue)}"
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Orders (last 10)" do
          table_for Order.order(created_at: :desc).limit(10) do
            column("ID") { |o| link_to o.id, admin_order_path(o) }
            column("User") { |o| o.user&.email }
            column :status
            column("Total") { |o| number_to_currency(o.total_price) }
            column("Time") { |o| o.created_at.strftime("%Y-%m-%d %H:%M") }
          end
        end
      end

      column do
        panel "Low Stock / Needs Attention" do
          ul do
            Product.where(is_on_sale: true).limit(8).each do |p|
              li do
                span link_to(p.name, admin_product_path(p))
                span "  — On Sale"
              end
            end
          end
          div class: "small text-muted mt-2" do
            "Tip: add stock_quantity later for real inventory alerts."
          end
        end
      end
    end
  end
end
