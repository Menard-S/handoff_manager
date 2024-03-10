require "test_helper"
require 'webdrivers/chromedriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Webdrivers::Chromedriver.required_version = '122.0.6261.94'
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400] do |driver_options|
    driver_options.add_argument('headless')
    driver_options.add_argument('disable-gpu')
  end

  def sign_in_as(fixture_name)
    user = users(fixture_name)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'test_password'
    click_on 'Get started'
  end

end
