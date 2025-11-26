class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # Allowlist attributes for Ransack searches used by ActiveAdmin filters.
  # Avoid listing sensitive fields such as encrypted_password or reset tokens.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id email remember_created_at created_at updated_at]
  end
end
