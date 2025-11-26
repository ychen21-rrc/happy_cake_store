class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy

  validates :status, presence: true

  # Explicitly allowlist searchable attributes for Ransack (used by ActiveAdmin filters).
  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id address_id status subtotal total_price gst_amount hst_amount pst_amount created_at updated_at]
  end

  # Explicitly allowlist searchable associations for Ransack (used by ActiveAdmin filters).
  def self.ransackable_associations(_auth_object = nil)
    %w[address order_items user]
  end
end
