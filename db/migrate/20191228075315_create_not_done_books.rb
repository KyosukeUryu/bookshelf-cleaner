class CreateNotDoneBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :not_done_books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :status, default: 0, null: false
      t.date :reading_expired

      t.timestamps
    end
  end
end
