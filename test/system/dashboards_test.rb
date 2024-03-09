require "application_system_test_case"

class DashboardsTest < ApplicationSystemTestCase
  test "visiting the dashboard" do
    visit dashboard_url
  end

  test "visiting the categories" do
    visit categories_path
  end
end