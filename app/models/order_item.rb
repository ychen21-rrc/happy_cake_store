class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, numericality: { greater_than: 0 }

  # Allowlist searchable attributes for Ransack (avoid sensitive fields)
  def self.ransackable_attributes(_auth_object = nil)
    %w[id order_id product_id quantity price_at_purchase created_at updated_at]
  end
  
  # Allowlist searchable associations for Ransack
  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end
