require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  setup do
    @round = rounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create round" do
    assert_difference('Round.count') do
      post :create, :round => { :claimable => @round.claimable, :date => @round.date, :doctor_id => @round.doctor_id, :duration => @round.duration, :finish => @round.finish, :hospital_id => @round.hospital_id, :start => @round.start }
    end

    assert_redirected_to round_path(assigns(:round))
  end

  test "should show round" do
    get :show, :id => @round
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @round
    assert_response :success
  end

  test "should update round" do
    put :update, :id => @round, :round => { :claimable => @round.claimable, :date => @round.date, :doctor_id => @round.doctor_id, :duration => @round.duration, :finish => @round.finish, :hospital_id => @round.hospital_id, :start => @round.start }
    assert_redirected_to round_path(assigns(:round))
  end

  test "should destroy round" do
    assert_difference('Round.count', -1) do
      delete :destroy, :id => @round
    end

    assert_redirected_to rounds_path
  end
end
