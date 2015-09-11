require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  test "should get index,show" do
    get :index,show
    assert_response :success
  end

end
