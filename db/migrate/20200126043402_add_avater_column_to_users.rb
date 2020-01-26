class AddAvaterColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avater, :text
  end
end
