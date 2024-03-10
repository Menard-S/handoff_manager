require "application_system_test_case"

class DashboardsTest < ApplicationSystemTestCase
  setup do
    sign_in_as(:one)

    @category_with_hours = categories(:hours_category)
    @category_with_words = categories(:words_category)

    @task_with_hours = tasks(:task_with_hours)
    @task_with_words = tasks(:task_with_words)
    puts "Tasks count: #{Task.count}"
    puts "First Task: #{Task.first.inspect}"
  end

  test "visiting the dashboard" do
    visit dashboard_url
  end

  test "filters tasks by date range" do
    visit dashboard_url
    
    script = "document.querySelector('#start_date').value = '#{Date.today.beginning_of_month.to_s}';"
    page.execute_script(script)
    script = "document.querySelector('#end_date').value = '#{Date.today.end_of_month.to_s}';"
    page.execute_script(script)
    page.execute_script("document.querySelector('#start_date').dispatchEvent(new Event('change'))")
    page.execute_script("document.querySelector('#end_date').dispatchEvent(new Event('change'))")
    click_on "Filter"
        

    assert_text @task_with_hours.name
    assert_text @task_with_words.name
  end

  test "search functionality filters tasks" do
    visit dashboard_url

    fill_in "searchBarInput", with: "Task with Hours"
    find("#button-addon2").click

    assert_text "Task with Hours"
    assert_no_text "Task with Words"
  end

end