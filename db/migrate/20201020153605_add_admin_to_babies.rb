class AddAdminToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :admin, :boolean, default: false
  end
end
