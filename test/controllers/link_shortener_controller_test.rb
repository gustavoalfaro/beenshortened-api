# frozen_string_literal: true

require 'test_helper'

# default test for LinkShortener Controller
class LinkShortenerControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get link_shortener_index_url
    assert_response :success
  end
end
