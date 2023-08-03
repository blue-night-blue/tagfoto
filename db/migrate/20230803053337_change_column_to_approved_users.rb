class ChangeColumnToApprovedUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :approved_users, :seacret_message_access, :secret_message_access
  end
end
