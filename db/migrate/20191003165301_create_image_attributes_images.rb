class CreateImageAttributesImages < ActiveRecord::Migration[6.0]
  def change
    create_table :image_attributes_images, id: :uuid do |t|
      t.references :image_attribute, null: false, foreign_key: true, type: :uuid
      t.references :image, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
