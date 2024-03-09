class DashboardControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      sign_in @user
    end
  
    test "should get index" do
      get dashboard_url
      assert_response :success
    end
  
    test "should filter tasks based on date range" do
      start_date = Date.current.to_s
      end_date = (Date.current + 5.days).to_s
      get dashboard_url, params: { start_date: start_date, end_date: end_date }
      assert_response :success
    end
  
    test "should reset tasks list" do
      get dashboard_url, params: { reset: true }
      assert_response :success
    end
  end
  