class CreateReadingSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :reading_sessions do |t|
      t.integer :pages_read
      t.integer :duration_minutes
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
