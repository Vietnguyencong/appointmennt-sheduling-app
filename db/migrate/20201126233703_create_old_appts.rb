class CreateOldAppts < ActiveRecord::Migration[6.0]
  def change
    create_table :old_appts do |t|

      t.timestamps
    end
  end
end
