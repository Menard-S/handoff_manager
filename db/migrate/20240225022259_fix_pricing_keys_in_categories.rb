class FixPricingKeysInCategories < ActiveRecord::Migration[6.0]
  def up
    Category.find_each do |category|
      pricing = category.pricing
      if pricing.is_a?(Hash)
        pricing['new_word'] = pricing.delete('new') if pricing.key?('new')
        pricing['leveraged_match'] = pricing.delete('leveraged') if pricing.key?('leveraged')
        category.update_columns(pricing: pricing) # Use update_columns to skip validations/callbacks
      end
    end
  end

  def down
    # Reverse the changes in case you need to rollback
    Category.find_each do |category|
      pricing = category.pricing
      if pricing.is_a?(Hash)
        pricing['new'] = pricing.delete('new_word') if pricing.key?('new_word')
        pricing['leveraged'] = pricing.delete('leveraged_match') if pricing.key?('leveraged_match')
        category.update_columns(pricing: pricing) # Use update_columns to skip validations/callbacks
      end
    end
  end
end
