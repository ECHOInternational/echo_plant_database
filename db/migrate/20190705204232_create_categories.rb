class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.timestamps
    end
    reversible do |dir|
    	dir.up do
    		Category.create_translation_table! name: {type: :string, null: false}, description: :text
    	end
    	dir.down do
    		Category.drop_translation_table!
    	end
    end
  end
end