class AddHasImgToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :has_img, :boolean, :default => false
  end
end
