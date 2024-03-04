require "application_system_test_case"

class DashboardsTest < ApplicationSystemTestCase
  test "visiting the dashboard" do
    visit dashboard_url
  end

  test "search tasks on dashboard" do
    visit dashboard_url

    assert_selector 'table tbody tr', minimum: 1, wait: 5

    matching_task_name = "Task with Hours"
    non_matching_task_name = "XXXX"

    # Simulate typing into the search bar
    fill_in 'searchBarInput', with: matching_task_name
    
    # Use assert_selector to wait for and verify that only tasks containing the search term are visible
    assert_selector 'table tbody tr', text: matching_task_name, wait: 5

    # Use assert_no_selector to verify that tasks not containing the search term are not visible
    assert_no_selector 'table tbody tr', text: non_matching_task_name, wait: 5
  end

end