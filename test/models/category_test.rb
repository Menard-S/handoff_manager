require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'should not save category without name' do
    category = Category.new(billing_unit: 'HOURS', pricing: {})
    assert_not category.save, 'Saved the category without a name'
  end

  test 'should not save category with duplicate name' do
    category1 = Category.create(name: 'Design', billing_unit: 'HOURS', pricing: {})
    category2 = Category.new(name: 'design', billing_unit: 'WORDS', pricing: {})
    assert_not category2.save, 'Saved the category with a duplicate name'
  end

  test 'should not save category without billing_unit' do
    category = Category.new(name: 'Development', pricing: {})
    assert_not category.save, 'Saved the category without a billing_unit'
  end

  test 'should not save category with invalid billing_unit' do
    category = Category.new(name: 'Development', billing_unit: 'MINUTES', pricing: {})
    assert_not category.save, 'Saved the category with an invalid billing_unit'
  end

  test 'should not save category if pricing is not a hash' do
    category = Category.new(name: 'Development', billing_unit: 'HOURS', pricing: 'invalid')
    assert_not category.save, 'Saved the category with invalid pricing'
  end

  test 'should save valid category' do
    user = users(:one)
    category = Category.new(name: 'Testing', billing_unit: 'WORDS', pricing: {}, user: user)
    assert category.save, 'Failed to save the valid category'
  end
end
