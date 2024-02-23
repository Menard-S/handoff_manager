class AddWordCountsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :word_counts, :jsonb, default: {}
  end
end
