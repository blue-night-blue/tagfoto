class ChangeDataTypeOfApprovedUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :approved_users, :string
  end
end
