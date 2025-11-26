class Category < ApplicationRecord
  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products

  validates :name, presence: true, uniqueness: true

  # Allowlist searchable associations for Ransack (used by ActiveAdmin filters)
  def self.ransackable_associations(_auth_object = nil)
    %w[category_products products]
  end

  # Allowlist searchable attributes for Ransack (avoid sensitive fields)
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end
end
