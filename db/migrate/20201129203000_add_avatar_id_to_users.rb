class AddAvatarIdToUsers < ActiveRecord::Migration[6.0]
  def change
    #use to store the id 
    add_column :users, :avatar_id, :integer 
  end
end

