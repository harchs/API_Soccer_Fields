class ChangeFormatIntToKeyApps < ActiveRecord::Migration
  def up
  	remove_column :key_apps, :app_id
  	add_column :key_apps, :app_id, :int
  end

  def down
  	add_column :key_apps, :app_id, :string
  end
end
