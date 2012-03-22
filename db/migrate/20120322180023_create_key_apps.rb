class CreateKeyApps < ActiveRecord::Migration
  def change
    create_table :key_apps do |t|
      t.string :public_key
      t.string :private_key
      t.string :app_name

      t.timestamps
    end
  end
end
