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
        total = task.word_counts.sum do |key, count|
          rate = task.category.pricing[key].to_f
          amount = count.to_f * rate
          puts "#{key}: #{count} * #{rate} = #{amount}" # Corrected debugging statement
          amount
        end
        puts "Total: #{total}" # For debugging
        total.round(2)
      
      else
        0
      end
    end
    
  end
  