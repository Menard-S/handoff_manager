class Task < ApplicationRecord
  belongs_to :category
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :billing_unit, to: :category, allow_nil: true

  
  # Ensure that the name is present
  validates :name, presence: true
  
  # Validate presence of deadline_date and deadline_time
  validates :deadline_date, presence: true
  validates :deadline_time, presence: true

  validate :deadline_date_cannot_be_in_the_past,
            unless: -> { only_completed_status_being_updated? }
  validate :deadline_time_cannot_be_in_the_past, if: -> { deadline_date.present? && deadline_time.present? },
            unless: -> { only_completed_status_being_updated? }
  
  # Conditional validations based on the associated category's billing unit
  with_options if: -> { category.billing_unit == 'HOURS' } do |task|
    task.validates :hours, presence: true, numericality: { greater_than: 0 }
  end

  with_options if: -> { category.billing_unit == 'WORDS' } do |task|
    task.validates :word_counts, presence: true
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
  
  private

  def deadline_date_cannot_be_in_the_past
    if deadline_date.present? && deadline_date < Date.current
      errors.add(:deadline_date, "can't be in the past")
    end
  end
  
  def only_completed_status_being_updated?
    # Checks if the only attribute being changed is the 'completed' attribute
    changes.keys == ['completed']
  end
  
  def deadline_time_cannot_be_in_the_past
    # Only perform this validation if the deadline date is today
    return unless deadline_date == Date.current
    
    # Convert deadline_time to a DateTime object for comparison
    deadline_datetime = DateTime.parse("#{deadline_date} #{deadline_time}")
    
    if deadline_datetime < DateTime.current
      errors.add(:deadline_time, "can't be in the past for today's date")
    end
  end
end
