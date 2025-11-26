ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  index do
    id_column
    column :title
    column :slug
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.rich_text_area :content
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |p|
        p.content # rich text render
      end
      row :updated_at
    end
  end
end
