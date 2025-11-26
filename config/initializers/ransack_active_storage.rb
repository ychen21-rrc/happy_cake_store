# frozen_string_literal: true

# Ransack (>= 4) requires models to explicitly define which attributes
# are searchable. ActiveAdmin uses Ransack for filters, and ActiveStorage
# models (Attachment/Blob) may be involved in admin filters for Product.
# Define safe `ransackable_attributes` here to avoid runtime errors.

Rails.application.config.to_prepare do
  if defined?(ActiveStorage)
    if defined?(ActiveStorage::Attachment)
      ActiveStorage::Attachment.class_eval do
        def self.ransackable_attributes(_auth_object = nil)
          %w[blob_id created_at id id_value name record_id record_type updated_at]
        end
      end
    end

    if defined?(ActiveStorage::Blob)
      ActiveStorage::Blob.class_eval do
        def self.ransackable_attributes(_auth_object = nil)
          %w[byte_size checksum content_type created_at filename id metadata service_name updated_at]
        end
      end
    end
  end
end
