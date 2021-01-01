class AddClassSessionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :class_session, :string
  end
end
