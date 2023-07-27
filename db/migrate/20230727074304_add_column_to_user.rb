class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :approved_users, :text, array: true
  end
end
