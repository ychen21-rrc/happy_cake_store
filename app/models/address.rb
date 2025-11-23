class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :street, :city, :postal_code, presence: true
  validates :postal_code, format: { with: /\A[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTVXY]\s?\d[ABCEGHJ-NPRSTVXY]\d\z/i }
end
