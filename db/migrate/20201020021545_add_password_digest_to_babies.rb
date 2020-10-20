class AddPasswordDigestToBabies < ActiveRecord::Migration[6.0]
  def change
    add_column :babies, :password_digest, :string
  end
end
