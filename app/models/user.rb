class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :orders
  # Each user can have one shipping/billing address record
  has_one :address, dependent: :destroy

  # Allowlist searchable attributes for Ransack (avoid sensitive fields)
  def self.ransackable_attributes(_auth_object = nil)
    %w[id email first_name last_name remember_created_at created_at updated_at]
  end
end
