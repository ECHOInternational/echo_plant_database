class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images, id: :uuid do |t|
      t.string :attribution
      t.string :s3_bucket
      t.string :s3_key
      t.timestamps
    end
    reversible do |dir|
    	dir.up do
    		Image.create_translation_table! name: {type: :string, null: false}, description: :text
    		add_column :image_translations, :uuid, :uuid, default: "gen_random_uuid()", null: false
		  	remove_column :image_translations, :id
		    rename_column :image_translations, :uuid, :id
		    execute "ALTER TABLE image_translations ADD PRIMARY KEY (id);"
    	end
    	dir.down do
    		ImageAttribute.drop_translation_table!
    	end
    end
  end
end
