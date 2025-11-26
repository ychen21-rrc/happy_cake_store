# frozen_string_literal: true

# Allow Ransack to search ActionText::RichText attributes.
# Ransack 4+ requires explicit allowlisting for attributes it may search.
Rails.application.config.to_prepare do
  ActionText::RichText.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[body created_at id id_value name record_id record_type updated_at]
    end
  end
end
# frozen_string_literal: true

# Ransack requires explicit allowlists for models starting with v4.
# ActionText::RichText is an application model created by Rails when
# using ActionText; ActiveAdmin may try to build filters against it.
# Define a conservative list of searchable attributes so Ransack does
# not raise at runtime when ActiveAdmin renders filter selects.
module RansackActionTextAllowlist
  def self.apply
    ::ActionText::RichText.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        %w[body created_at id id_value name record_id record_type updated_at]
      end
    end
  rescue NameError
    # If ActionText::RichText isn't loaded yet (e.g., in some rake tasks),
    # we quietly skip. Rails will load this class in normal requests.
  end
end

RansackActionTextAllowlist.apply
