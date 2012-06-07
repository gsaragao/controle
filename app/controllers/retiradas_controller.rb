# encoding : utf-8
class RetiradasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :trata_params, :only => [:index]
  before_filter :carrega_retirada , :only => [:show, :edit, :update, :destroy]

  def index
    @tecnicos = Tecnico.all(:order => 'nome')
    @retirada = Retirada.new(params[:retirada])
    @retiradas = Retirada.pesquisar(params[:retirada],params[:page])
    
    if (@retiradas.size > 0)
       @retiradas.each {|ret|
         carrega_interna(ret)
       }
    end
    
    respond_with @retiradas
  end

  def show
    carrega_interna(@retirada)    
    respond_with @retirada
  end

  def new
    carrega_combos
    @retirada = Retirada.new
    @retirada.operacao = Retirada::INTERNA
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
    @origens = Endereco.pesquisar_tipo(Endereco::ORIGEM)
    @destinos = Endereco.pesquisar_tipo(Endereco::DESTINO)
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
  
  def carrega_interna(retirada)
    
    if (retirada.operacao == Retirada::INTERNA)
        retirada.serie = retirada.movimentacao.serie
      	retirada.patrimonio = retirada.movimentacao.patrimonio
      	retirada.tecnico_id = retirada.movimentacao.tecnico_id
      	retirada.versao_id = retirada.movimentacao.versao_id
      	retirada.modelo_id = retirada.movimentacao.modelo_id
      	retirada.nfe_referencia = retirada.movimentacao.nfe
      	retirada.data_instalacao = retirada.movimentacao.data_movimentacao
      	retirada.ordem_servico = retirada.movimentacao.ordem_servico
	  end
  end
  
end
