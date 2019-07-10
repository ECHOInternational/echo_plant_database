class AddLocaleToVersions < ActiveRecord::Migration[6.0]
  def change
  	change_table :versions do |t|
  		t.string :locale
  	end
  end
end
