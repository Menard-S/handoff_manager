module TasksHelper
    def display_word_counts(word_counts)
      return 'N/A' unless word_counts.present?
      word_counts.map { |key, value| "#{key.humanize}: #{value}" }.join(', ')
    end
  
    def calculate_total_amount(task)
      case task.category.billing_unit
      when 'HOURS'
        task.hours.to_f * task.category.pricing['hourly'].to_f
      when 'WORDS'
        # Assuming word_counts is a hash like { "new_word" => 100, "fuzzy_75_84" => 50, ... }
        task.word_counts.sum { |key, count| count.to_f * task.category.pricing[key].to_f }
      else
        0
      end.round(2) # Rounds the result to 2 decimal places
    end
  end
  