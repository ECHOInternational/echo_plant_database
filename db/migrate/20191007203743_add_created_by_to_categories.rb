class AddCreatedByToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :created_by, :string
  end
end
