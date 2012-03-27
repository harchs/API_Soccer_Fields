class RenameTableUserToUsers < ActiveRecord::Migration
  def up
  	rename_table("users", "user")
  end

  def down
  end
end
