class AddVisibleToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :visible, :boolean, default: true
  end
end
