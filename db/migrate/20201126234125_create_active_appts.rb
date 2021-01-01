class CreateActiveAppts < ActiveRecord::Migration[6.0]
  def change
    create_table :active_appts do |t|

      t.timestamps
    end
  end
end
