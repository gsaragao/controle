class HomeController < ApplicationController
  
  before_filter :setar_classe_menu
  
  def index
    @destinos = Destino.all
    @modelos = Modelo.all
    @versoes = Versao.all
    @tecnicos = Tecnico.all
  end  
  
  private

  def setar_classe_menu
    @class_home = 'active'  
  end
  
end