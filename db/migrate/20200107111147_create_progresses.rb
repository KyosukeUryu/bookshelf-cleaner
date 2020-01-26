class CreateProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :progresses do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
