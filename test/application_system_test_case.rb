require "test_helper"
require 'webdrivers/chromedriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Webdrivers::Chromedriver.required_version = '122.0.6261.94'
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400] do |driver_options|
    driver_options.add_argument('headless')
    driver_options.add_argument('disable-gpu')
  end

  def sign_in_as(user_fixture)
    visit signin_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'test_password'
    click_on 'Log in'
  end

end
