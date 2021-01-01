class AddApptIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :appt_id, :integer
  end
end
