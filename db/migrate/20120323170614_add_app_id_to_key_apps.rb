class AddAppIdToKeyApps < ActiveRecord::Migration
  def change
    add_column :key_apps, :app_id, :string
  end

  def self.up
  	remove_column :key_apps, :app_name
  end
end
