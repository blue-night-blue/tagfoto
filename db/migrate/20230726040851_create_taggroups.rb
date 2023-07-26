class CreateTaggroups < ActiveRecord::Migration[7.0]
  def change
    create_table :taggroups do |t|
      t.string :group
      t.string :sort_order
      t.integer :user_id

      t.timestamps
    end
  end
end
