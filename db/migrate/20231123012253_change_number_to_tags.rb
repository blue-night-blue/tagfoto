class ChangeNumberToTags < ActiveRecord::Migration[7.0]
  def change
    change_column :tags, :group_number, :string, using: 'group_number::string'
  end
end
