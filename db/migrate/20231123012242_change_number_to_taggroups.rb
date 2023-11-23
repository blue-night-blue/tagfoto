class ChangeNumberToTaggroups < ActiveRecord::Migration[7.0]
  def change
    change_column :taggroups, :number, :string, using: 'number::string'
  end
end
