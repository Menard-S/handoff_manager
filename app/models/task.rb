class Task < ApplicationRecord
  belongs_to :category
  
  # Ensure that the name is present
  validates :name, presence: true
  
  # Validate presence of deadline_date and deadline_time
  validates :deadline_date, presence: true
  validates :deadline_time, presence: true
  
  # Conditional validations based on the associated category's billing unit
  with_options if: -> { category.billing_unit == 'HOURS' } do |task|
    task.validates :hours, presence: true, numericality: { greater_than: 0 }
  end

  with_options if: -> { category.billing_unit == 'WORDS' } do |task|
    task.validates :word_counts, presence: true
    # Here you might validate the structure of word_count if it's a JSON
    # Similar to the pricing_structure validation in Category
  end
  
  def word_counts_presence_and_structure
    if word_counts.blank? || word_counts.values.any?(&:blank?)
      errors.add(:word_counts, "can't be blank and must have all required fields")
    end
  end

  # Scope to get completed tasks
  scope :completed, -> { where(completed: true) }

  # Scope to get incomplete tasks
  scope :incomplete, -> { where(completed: [nil, false]) }
  
end
