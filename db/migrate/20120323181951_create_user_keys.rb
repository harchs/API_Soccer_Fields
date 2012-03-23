class CreateUserKeys < ActiveRecord::Migration
  def change
    create_table :user_keys do |t|
      t.string :provider
      t.string :auth
      t.string :credential
      t.string :app_id

      t.timestamps
    end
  end
end
