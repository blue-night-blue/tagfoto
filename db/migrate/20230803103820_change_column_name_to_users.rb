class ChangeColumnNameToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :seacret_message, :secret_message
  end
end
