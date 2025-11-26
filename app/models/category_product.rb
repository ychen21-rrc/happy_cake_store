class CategoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :category

  # Allowlist attributes that Ransack is allowed to search on.
  # See Ransack error: define `ransackable_attributes` to avoid runtime errors.
  def self.ransackable_attributes(auth_object = nil)
    %w[id product_id category_id created_at updated_at]
  end
end
