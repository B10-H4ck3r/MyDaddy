class AddTextPriceToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :text_price, :string
  end
end
