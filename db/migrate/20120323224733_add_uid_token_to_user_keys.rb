class AddUidTokenToUserKeys < ActiveRecord::Migration
  def change
    add_column :user_keys, :uid, :string

    add_column :user_keys, :token, :string

  end
end
