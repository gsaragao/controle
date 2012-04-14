require 'test_helper'

class DevolucoesControllerTest < ActionController::TestCase
  setup do
    @devolucao = devolucoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:devolucoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create devolucao" do
    assert_difference('Devolucao.count') do
      post :create, devolucao: @devolucao.attributes
    end

    assert_redirected_to devolucao_path(assigns(:devolucao))
  end

  test "should show devolucao" do
    get :show, id: @devolucao.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @devolucao.to_param
    assert_response :success
  end

  test "should update devolucao" do
    put :update, id: @devolucao.to_param, devolucao: @devolucao.attributes
    assert_redirected_to devolucao_path(assigns(:devolucao))
  end

  test "should destroy devolucao" do
    assert_difference('Devolucao.count', -1) do
      delete :destroy, id: @devolucao.to_param
    end

    assert_redirected_to devolucoes_path
  end
end
