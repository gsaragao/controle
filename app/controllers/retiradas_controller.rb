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
    respond_with @retiradas
  end

  def show
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
    
    result = validar_movimentacao
    
    if result && @retirada.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to retiradas_path
    else 
      
      if (!result)
        flash[:alert] = t('retirada.erro_operacao')
      end  
    
      carrega_combos
      render :action => :new 
    end
     
  end

  def update
    
    result = validar_movimentacao

    if result && @retirada.update_attributes(params[:retirada])
      flash[:notice] = t('msg.update_sucess')
      redirect_to retiradas_path
    else
      
      if (!result)
        flash[:alert] = t('retirada.erro_operacao')
      end  
      
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
  
  def validar_movimentacao
    if (params[:retirada][:operacao] == Retirada::INTERNA)
       movimentacao = Movimentacao.new 
       movimentacao.serie = params[:retirada][:serie]
       movimentacao.patrimonio = params[:retirada][:patrimonio]
       movimentacao.tecnico_id = params[:retirada][:tecnico_id]
       movimentacao.modelo_id = params[:retirada][:modelo_id]
       movimentacao.versao_id = params[:retirada][:versao_id]
       @movimentacoes = Movimentacao.valida_movimento(movimentacao)
       @movimentacoes.size > 0 ? true : false
    else
       true 
    end  
  end
  
end
