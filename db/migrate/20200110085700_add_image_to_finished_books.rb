class AddImageToFinishedBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :finished_books, :image, :text
  end
end
