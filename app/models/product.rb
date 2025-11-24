class Product < ApplicationRecord
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many_attached :images

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  # Ransack (used by ActiveAdmin filters) requires associations to be explicitly
  # allowlisted for searching. Only expose safe, non-sensitive associations here.
  def self.ransackable_associations(auth_object = nil)
    %w[categories category_products images_attachments images_blobs]
  end

  # Ransack (used by ActiveAdmin filters) also requires attributes to be
  # explicitly allowlisted. Keep sensitive fields out of this list.
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at description id id_value is_new is_on_sale name price updated_at]
  end
end
