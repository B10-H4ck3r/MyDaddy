class AddIndexToBabiesEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :babies, :email, unique: true
  end
end
