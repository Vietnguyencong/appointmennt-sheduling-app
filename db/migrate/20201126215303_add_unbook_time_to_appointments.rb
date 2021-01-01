class AddUnbookTimeToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :unbook_time, :integer
  end
end
