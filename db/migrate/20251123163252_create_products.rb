class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :is_new
      t.boolean :is_on_sale

      t.timestamps
    end
  end
end
