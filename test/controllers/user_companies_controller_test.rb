require 'test_helper'

class UserCompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_companies_index_url
    assert_response :success
  end

end
