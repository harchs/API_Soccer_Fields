class RenameTableAppToApps < ActiveRecord::Migration
  def up
  	rename_table("apps", "app")
  end

  def down
  end
end
