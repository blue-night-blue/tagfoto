class RenameColumnInApprovedUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :approved_users, :approved_user, :approved_user_id
  end
end
