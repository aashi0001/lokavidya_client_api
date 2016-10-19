class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.string :password_confirmation
      t.string :confirmation_link
      t.boolean :is_active, default: false

      t.timestamps
    end
  end
end
