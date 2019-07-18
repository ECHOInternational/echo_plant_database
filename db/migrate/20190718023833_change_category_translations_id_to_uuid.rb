# Because we are using UUIDs on some of our models, we have to use uuids on all
# tables that interact with the paper trail gem. 

class ChangeCategoryTranslationsIdToUuid < ActiveRecord::Migration[6.0]
  def up
  	add_column :category_translations, :uuid, :uuid, default: "gen_random_uuid()", null: false
  	remove_column :category_translations, :id
    rename_column :category_translations, :uuid, :id
    execute "ALTER TABLE category_translations ADD PRIMARY KEY (id);"
  end
end
