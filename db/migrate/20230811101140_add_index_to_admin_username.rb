class AddIndexToAdminUsername < ActiveRecord::Migration[7.0]
  def change
    add_index :admins, :username, unique: true
  end
end
