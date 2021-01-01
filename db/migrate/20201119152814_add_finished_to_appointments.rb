class AddFinishedToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :finsihed, :boolean, :default => false
  end
end
