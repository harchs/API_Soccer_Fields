class RenameTableAppsToApp < ActiveRecord::Migration
  def up
  	rename_table("app", "apps")
  end

  def down
  end
end
