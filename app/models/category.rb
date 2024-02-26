class Category < ApplicationRecord
    has_many :tasks
    
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    
    validates :billing_unit, presence: true, inclusion: { in: %w(HOURS WORDS), 
                                                          message: "%{value} is not a valid billing unit" }
    
    validate :pricing_structure
  
    private
  
    def pricing_structure
      errors.add(:pricing, "must be a hash") unless pricing.is_a?(Hash)
      
    end
  end
  