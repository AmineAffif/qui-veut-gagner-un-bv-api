class AddAuthenticationTokenToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :authentication_token, :string
    add_index :admin_users, :authentication_token, unique: true
  end
end
