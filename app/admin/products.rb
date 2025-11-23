ActiveAdmin.register Product do
  permit_params :name, :description, :price, :is_new, :is_on_sale, category_ids: [], images: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :is_new
      f.input :is_on_sale
      f.input :categories, as: :check_boxes
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :is_new
      row :is_on_sale
      row :categories
      row :images do |p|
        p.images.each do |img|
          span image_tag(img.variant(resize_to_limit: [200, 200]))
        end
      end
    end
  end
end
