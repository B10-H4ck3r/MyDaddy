class AddSexToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :sex, :string
  end
end
