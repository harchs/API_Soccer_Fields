class AddUserIdToUserKeys < ActiveRecord::Migration
  def change
    add_column :user_keys, :user_id, :string

  end
end
