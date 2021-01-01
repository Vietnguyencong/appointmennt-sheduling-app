class AddStartTimeToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :starttime, :datetime
  end
end
