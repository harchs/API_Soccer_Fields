class RemoveAppNameFromKeyApps < ActiveRecord::Migration
  def up
    remove_column :key_apps, :app_name
   end

  def down
    add_column :key_apps, :app_name, :string
  end
end
