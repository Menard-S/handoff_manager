require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @category_hours = categories(:hours_category)
    @category_words = categories(:words_category)
  end

  test 'should not save task without name' do
    task = Task.new(category: @category_hours, deadline_date: Date.tomorrow, deadline_time: "14:00")
    assert_not task.save, 'Saved the task without a name'
  end

  test 'should not save task without deadline_date' do
    task = Task.new(name: 'Task without deadline', category: @category_hours, deadline_time: "14:00")
    assert_not task.save, 'Saved the task without a deadline_date'
  end

  test 'should not save task with deadline_date in the past' do
    task = Task.new(name: 'Past Deadline Task', category: @category_hours, deadline_date: Date.yesterday, deadline_time: "14:00")
    assert_not task.save, 'Saved the task with a deadline_date in the past'
  end

  test 'should not save task without hours when category billing_unit is HOURS' do
    task = Task.new(name: 'Task with no hours', category: @category_hours, deadline_date: Date.tomorrow, deadline_time: "14:00")
    assert_not task.save, 'Saved the task without hours when category billing_unit is HOURS'
  end

  test 'should not save task without word_counts when category billing_unit is WORDS' do
    task = Task.new(name: 'Task with no word counts', category: @category_words, deadline_date: Date.tomorrow, deadline_time: "14:00")
    assert_not task.save, 'Saved the task without word_counts when category billing_unit is WORDS'
  end

  test 'should save valid task with hours' do
    task = Task.new(name: 'Valid Task with Hours', category: @category_hours, deadline_date: Date.tomorrow, deadline_time: "14:00", hours: 2)
    assert task.save, 'Failed to save the valid task with hours'
  end

  test 'should save valid task with word_counts' do
    task = Task.new(name: 'Valid Task with Words', category: @category_words, deadline_date: Date.tomorrow, deadline_time: "14:00", word_counts: { "section1" => 1000 })
    assert task.save, 'Failed to save the valid task with word_counts'
  end

end
