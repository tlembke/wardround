require 'test_helper'

class ClaimsControllerTest < ActionController::TestCase
  setup do
    @claim = claims(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claims)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create claim" do
    assert_difference('Claim.count') do
      post :create, :claim => { :date => @claim.date, :doctor_id => @claim.doctor_id, :duration => @claim.duration, :finish => @claim.finish, :hospital_id => @claim.hospital_id, :round_id => @claim.round_id, :start => @claim.start }
    end

    assert_redirected_to claim_path(assigns(:claim))
  end

  test "should show claim" do
    get :show, :id => @claim
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @claim
    assert_response :success
  end

  test "should update claim" do
    put :update, :id => @claim, :claim => { :date => @claim.date, :doctor_id => @claim.doctor_id, :duration => @claim.duration, :finish => @claim.finish, :hospital_id => @claim.hospital_id, :round_id => @claim.round_id, :start => @claim.start }
    assert_redirected_to claim_path(assigns(:claim))
  end

  test "should destroy claim" do
    assert_difference('Claim.count', -1) do
      delete :destroy, :id => @claim
    end

    assert_redirected_to claims_path
  end
end
