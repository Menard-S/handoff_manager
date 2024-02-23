class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :deadline_date
      t.time :deadline_time
      t.decimal :hours
      t.jsonb :word_count
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
