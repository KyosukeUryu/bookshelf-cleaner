class CreateConcernBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :concern_books do |t|
      t.references :user, foreign_key: true
      t.references :finished_book, foreign_key: true

      t.timestamps
    end
  end
end
