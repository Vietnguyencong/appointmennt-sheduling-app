class AddDateToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :date, :string
  end
end
