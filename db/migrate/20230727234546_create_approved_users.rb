class CreateApprovedUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :approved_users do |t|
      t.integer :user_id
      t.integer :approved_user
      t.boolean :authenticated

      t.timestamps
    end
  end
end
