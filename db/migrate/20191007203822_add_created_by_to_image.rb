class AddCreatedByToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :created_by, :string
  end
end
