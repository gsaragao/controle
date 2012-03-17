require 'test_helper'

class MovimentacoesControllerTest < ActionController::TestCase
  setup do
    @movimentacao = movimentacoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movimentacoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movimentacao" do
    assert_difference('Movimentacao.count') do
      post :create, movimentacao: @movimentacao.attributes
    end

    assert_redirected_to movimentacao_path(assigns(:movimentacao))
  end

  test "should show movimentacao" do
    get :show, id: @movimentacao.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movimentacao.to_param
    assert_response :success
  end

  test "should update movimentacao" do
    put :update, id: @movimentacao.to_param, movimentacao: @movimentacao.attributes
    assert_redirected_to movimentacao_path(assigns(:movimentacao))
  end

  test "should destroy movimentacao" do
    assert_difference('Movimentacao.count', -1) do
      delete :destroy, id: @movimentacao.to_param
    end

    assert_redirected_to movimentacoes_path
  end
end
