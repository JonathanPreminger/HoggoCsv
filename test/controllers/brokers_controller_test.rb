require 'test_helper'

class BrokersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brokers_index_url
    assert_response :success
  end

end
