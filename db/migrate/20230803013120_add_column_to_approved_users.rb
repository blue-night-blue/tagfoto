class AddColumnToApprovedUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :approved_users, :seacret_message_access, :boolean
  end
end
