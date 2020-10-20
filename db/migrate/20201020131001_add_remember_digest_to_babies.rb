class AddRememberDigestToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :remember_digest, :string
  end
end
