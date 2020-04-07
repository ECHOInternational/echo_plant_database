class ChangeImageableNullToFalse < ActiveRecord::Migration[6.0]
  def change
  	change_column_null(:images, :imageable_type, true)
  	change_column_null(:images, :imageable_id, true)
  end
end