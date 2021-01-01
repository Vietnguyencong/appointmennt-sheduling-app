class AddOldApptsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :old_appts, null: true, foreign_key: true
  end
end
