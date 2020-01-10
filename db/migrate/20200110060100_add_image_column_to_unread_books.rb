class AddImageColumnToUnreadBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :unread_books, :image, :text
  end
end
