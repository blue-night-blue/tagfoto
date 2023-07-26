class Tags < ActiveRecord::Migration[7.0]
  def change
    rename_column :tags, :number, :sort_order
    change_column :tags, :sort_order, :string
  end
end