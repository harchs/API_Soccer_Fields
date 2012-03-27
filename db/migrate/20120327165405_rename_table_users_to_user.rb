class RenameTableUsersToUser < ActiveRecord::Migration
  def up
  	rename_table("user", "users")
  end

  def down
  end
end
