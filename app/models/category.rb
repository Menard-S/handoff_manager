class Category < ApplicationRecord
    has_many :tasks
    
    # Ensure that the name is present and unique
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    
    # Ensure that the billing unit is either 'HOURS' or 'WORDS'
    validates :billing_unit, presence: true, inclusion: { in: %w(HOURS WORDS), 
                                                          message: "%{value} is not a valid billing unit" }
    
    # Optionally validate the structure of the pricing JSON
    validate :pricing_structure
  
    private
  
    # Custom validator for the pricing JSON structure
    def pricing_structure
      # Ensure that pricing is a hash and has the necessary keys based on billing_unit
      errors.add(:pricing, "must be a hash") unless pricing.is_a?(Hash)
      
      # You can add more specific validations here based on your pricing logic
      # For example, if 'HOURS' then it should have an 'hourly' key with a valid number
      # If 'WORDS' it should have appropriate keys for the different match percentages
    end
  end
  