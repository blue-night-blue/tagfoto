class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :user_id
      t.string :name
      t.integer :number
      t.string :group

      t.timestamps
    end
  end
end
