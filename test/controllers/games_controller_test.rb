require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get random_question" do
    get games_random_question_url
    assert_response :success
  end
end
