class AddRoleToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :role, :integer
  end
end
