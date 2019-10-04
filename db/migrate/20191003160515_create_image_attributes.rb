class CreateImageAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :image_attributes, id: :uuid do |t|
      t.timestamps
    end
    reversible do |dir|
    	dir.up do
    		ImageAttribute.create_translation_table! name: {type: :string, null: false}
    		add_column :image_attribute_translations, :uuid, :uuid, default: "gen_random_uuid()", null: false
		  	remove_column :image_attribute_translations, :id
		    rename_column :image_attribute_translations, :uuid, :id
		    execute "ALTER TABLE image_attribute_translations ADD PRIMARY KEY (id);"
    	end
    	dir.down do
    		ImageAttribute.drop_translation_table!
    	end
    end
  end
end