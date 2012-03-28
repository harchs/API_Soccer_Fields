class ChangeFormatIntToUserKeys < ActiveRecord::Migration
  def up
  	remove_column :user_keys, :app_id
  	add_column :user_keys, :app_id, :int
  	remove_column :user_keys, :user_id
  	add_column :user_keys, :user_id, :int
  end

  def down
  	add_column :user_keys, :app_id, :string
  	add_column :user_keys, :user_id, :string
  end
end
