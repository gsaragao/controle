class HomeController < ApplicationController
  
  before_filter :setar_classe_menu
  
  def index
    @enderecos = Endereco.all
    @modelos = Modelo.all
    @versoes = Versao.all
    @tecnicos = Tecnico.all
    @movimentacoes = Movimentacao.all
    @retiradas = Retirada.all
    @devolucoes = Devolucao.all
  end  
  
  private

  def setar_classe_menu
    @class_home = 'active'  
  end
  
end