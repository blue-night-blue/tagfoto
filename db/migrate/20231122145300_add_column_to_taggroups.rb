class AddColumnToTaggroups < ActiveRecord::Migration[7.0]
  def change
    add_column :taggroups, :number, :integer
  end
end
