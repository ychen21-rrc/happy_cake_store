class Page < ApplicationRecord
  has_rich_text :content
  validates :title, presence: true, uniqueness: true

  # Allowlist searchable associations for Ransack (ActionText rich text association)
  def self.ransackable_associations(_auth_object = nil)
    %w[rich_text_content]
  end

  # Allowlist searchable attributes for Ransack (avoid sensitive fields)
  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at id title updated_at]
  end
end
