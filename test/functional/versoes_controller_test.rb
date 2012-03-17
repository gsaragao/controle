require 'test_helper'

class VersoesControllerTest < ActionController::TestCase
  setup do
    @versao = versoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:versoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create versao" do
    assert_difference('Versao.count') do
      post :create, versao: @versao.attributes
    end

    assert_redirected_to versao_path(assigns(:versao))
  end

  test "should show versao" do
    get :show, id: @versao.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @versao.to_param
    assert_response :success
  end

  test "should update versao" do
    put :update, id: @versao.to_param, versao: @versao.attributes
    assert_redirected_to versao_path(assigns(:versao))
  end

  test "should destroy versao" do
    assert_difference('Versao.count', -1) do
      delete :destroy, id: @versao.to_param
    end

    assert_redirected_to versoes_path
  end
end
