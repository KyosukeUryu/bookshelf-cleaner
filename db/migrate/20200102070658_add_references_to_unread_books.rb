class AddReferencesToUnreadBooks < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM unread_books;'
    add_reference :unread_books, :user, null: false, index: true, foreign_key: true
  end

  def down
    remove_reference :unread_books, :user, index: true
  end
end
