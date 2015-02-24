class AddDnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dn, :string
  end
end
