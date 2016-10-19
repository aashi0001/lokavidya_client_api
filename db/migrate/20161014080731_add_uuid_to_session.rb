class AddUuidToSession < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :uuid, :string
    #add_index :sessions, :uuid, unique: true
  
  end
end
