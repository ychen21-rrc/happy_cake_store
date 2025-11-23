class Province < ApplicationRecord
  has_many :addresses
  validates :name, presence: true, uniqueness: true
  validates :gst, :pst, :hst, numericality: { greater_than_or_equal_to: 0 }
end
