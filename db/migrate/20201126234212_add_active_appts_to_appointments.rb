class AddActiveApptsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :active_appt, null: true, foreign_key: true
  end
end
