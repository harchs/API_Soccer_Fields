class RemoveProviderAuthFromUserKeys < ActiveRecord::Migration
  def up
    remove_column :user_keys, :provider
        remove_column :user_keys, :auth
        remove_column :user_keys, :user_keys
      end

  def down
    add_column :user_keys, :user_keys, :string
    add_column :user_keys, :auth, :string
    add_column :user_keys, :provider, :string
  end
end
