# encoding : utf-8
class RetiradasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :trata_params, :only => [:index]
  before_filter :carrega_retirada , :only => [:show, :edit, :update, :destroy]

  def index
    @tecnicos = Tecnico.all(:order => 'nome')
    @retirada = Retirada.new
    @retiradas = Retirada.pesquisar(params[:retirada],params[:page])
    respond_with @retiradas
    
  end

  def show
    respond_with @retirada
  end

  def new
    carrega_combos
    @retirada = Retirada.new
    @retirada.data_retirada = Date.today
    respond_with @retirada
  end

  def edit
    carrega_combos
  end

  def create
    @retirada = Retirada.new(params[:retirada])
    
    if @retirada.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to retiradas_path
    else
      carrega_combos
      render :action => :new 
    end
     
  end

  def update

    if @retirada.update_attributes(params[:retirada])
      flash[:notice] = t('msg.update_sucess')
      redirect_to retiradas_path
    else
      carrega_combos
      render :action => :edit
    end
  end

  def destroy
    @retirada.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to retiradas_path
  end
  
  private

  def setar_classe_menu
    @class_retirada = 'active'  
  end
  
  def carrega_combos 
    @tecnicos = Tecnico.all(:order => "nome")
    @modelos = Modelo.all(:order => "descricao")
    @versoes = Versao.all(:order => "descricao")
  end
  
  def carrega_retirada
    @retirada = Retirada.find(params[:id])
  end
  
  
  def trata_params
    if (!params[:retirada].nil?) 
       params[:retirada][:data_retirada] = trata_data(params[:retirada][:data_retirada]) if params[:retirada][:data_retirada]
       params[:retirada].delete_if{|k,v| v.blank?}
    end
  end
  
  
end
