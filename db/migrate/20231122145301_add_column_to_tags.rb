class AddColumnToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :group_number, :integer
  end
end
