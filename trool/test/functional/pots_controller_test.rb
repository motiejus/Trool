require 'test_helper'

class PotsControllerTest < ActionController::TestCase
  setup do
    @pot = pots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pot" do
    assert_difference('Pot.count') do
      post :create, :pot => @pot.attributes
    end

    assert_redirected_to pot_path(assigns(:pot))
  end

  test "should show pot" do
    get :show, :id => @pot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pot.to_param
    assert_response :success
  end

  test "should update pot" do
    put :update, :id => @pot.to_param, :pot => @pot.attributes
    assert_redirected_to pot_path(assigns(:pot))
  end

  test "should destroy pot" do
    assert_difference('Pot.count', -1) do
      delete :destroy, :id => @pot.to_param
    end

    assert_redirected_to pots_path
  end
end
