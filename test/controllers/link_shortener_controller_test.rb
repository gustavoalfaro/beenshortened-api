require 'test_helper'

class LinkShortenerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get link_shortener_index_url
    assert_response :success
  end

end
