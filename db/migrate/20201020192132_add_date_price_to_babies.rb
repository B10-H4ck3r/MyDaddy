class AddDatePriceToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :date_price, :string
  end
end
