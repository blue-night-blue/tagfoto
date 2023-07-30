class CreateSecretPhrases < ActiveRecord::Migration[7.0]
  def change
    create_table :secret_phrases do |t|
      t.integer :user_id
      t.string :password_digest

      t.timestamps
    end
  end
end
