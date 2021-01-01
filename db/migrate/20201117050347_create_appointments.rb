class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.string :time
      t.text :questions
      t.boolean :booked, :default => false

      t.timestamps
    end
  end
end
