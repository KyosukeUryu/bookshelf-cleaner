class CreateFinishedBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :finished_books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :status, null: false, default: 0
      t.date :desposal_expired
      t.text :impression
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
