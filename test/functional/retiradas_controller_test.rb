require 'test_helper'

class RetiradasControllerTest < ActionController::TestCase
  setup do
    @retirada = retiradas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:retiradas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create retirada" do
    assert_difference('Retirada.count') do
      post :create, retirada: @retirada.attributes
    end

    assert_redirected_to retirada_path(assigns(:retirada))
  end

  test "should show retirada" do
    get :show, id: @retirada.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @retirada.to_param
    assert_response :success
  end

  test "should update retirada" do
    put :update, id: @retirada.to_param, retirada: @retirada.attributes
    assert_redirected_to retirada_path(assigns(:retirada))
  end

  test "should destroy retirada" do
    assert_difference('Retirada.count', -1) do
      delete :destroy, id: @retirada.to_param
    end

    assert_redirected_to retiradas_path
  end
end
