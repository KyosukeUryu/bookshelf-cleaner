class RenameNotDoneBooksToUnreadBooks < ActiveRecord::Migration[5.2]
  def change
    rename_table :not_done_books, :unread_books
  end
end
