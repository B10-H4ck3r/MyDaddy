class CreateBabies < ActiveRecord::Migration[6.0]
  def change
    create_table :babies do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
