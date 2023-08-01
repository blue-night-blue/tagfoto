class ChangeUserIdToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :tags, :user_id, :integer, using: 'user_id::integer'
  end
end
