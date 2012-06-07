# encoding : utf-8
class MovimentacoesController < ApplicationController
  
  layout "application", :except => [:popup]
  respond_to :html, :js
  before_filter :setar_classe_menu
  before_filter :trata_params, :only => [:index, :popup]
  before_filter :carrega_movimentacao , :only => [:show, :edit, :update, :destroy]
  
  def index
    @tecnicos = Tecnico.all(:order => 'nome')
    @movimentacao = Movimentacao.new(params[:movimentacao])
    @movimentacoes = Movimentacao.pesquisar(params[:movimentacao],params[:page])
    respond_with @movimentacoes
  end
 
  def popup
    @tecnicos = Tecnico.all(:order => 'nome')
    @movimentacao = Movimentacao.new(params[:movimentacao])
    @movimentacoes = Movimentacao.pesquisar_popup(params[:movimentacao],params[:page])
    respond_with @movimentacoes
  end
 
  def show
    respond_with @movimentacao
  end

  def new
    carrega_combos
    @movimentacao = Movimentacao.new
    @movimentacao.status = Movimentacao::GOOD
    @movimentacao.data_movimentacao = Date.today
    @movimentacao.data_entrada = Date.today
    respond_with @movimentacao
  end

  def edit
    carrega_combos
    
    if (!params[:acao].nil?) 
      @movimentacao.acao = params[:acao]
    end  
    
  end

  def create
    @movimentacao = Movimentacao.new(params[:movimentacao])
    @ultimo_mov = Movimentacao.ultimo_nid
    @movimentacao = set_nid_versao_create(@movimentacao, @ultimo_mov)

    if @movimentacao.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to movimentacoes_path
    else
      carrega_combos
      render :action => :new 
    end

  end

  def update
    
    if (!params[:movimentacao][:acao].nil? && params[:movimentacao][:acao] == Movimentacao::ACAO_MOVIMENTACAO)
      @ultimo_mov = Movimentacao.ultima_versao(@movimentacao.nid)
      @movimentacao = set_nid_versao_update(@movimentacao, @ultimo_mov)
      @movimentacao.attributes = params[:movimentacao]
      
      Movimentacao.transaction do
        if @movimentacao.save! && @ultimo_mov.update_attribute(:ativo, 0)
          flash[:notice] = t('msg.update_sucess')
          redirect_to movimentacoes_path
        else
          carrega_combos
          render :action => :edit
        end
      end
    elsif (!params[:movimentacao][:acao].nil? && params[:movimentacao][:acao] == Movimentacao::ACAO_UPDATE)
      if @movimentacao.update_attributes(params[:movimentacao])
        flash[:notice] = t('msg.update_sucess')
        redirect_to movimentacoes_path
      else
        carrega_combos
        render :action => :edit
      end
    end    
  end

  def destroy
    @movimentacao.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to movimentacoes_path
  end
  
  private

  def setar_classe_menu
    @class_movimentacao = 'active'  
  end
  
  def set_nid_versao_create(movimentacao, ultimo_mov)

    movimentacao.version = 1
    movimentacao.ativo = 1
    
    if (ultimo_mov != nil && ultimo_mov.nid > 0)
      movimentacao.nid =  ultimo_mov.nid + 1
    else
      movimentacao.nid = 1
    end  
   
    movimentacao 
  end
  
  def set_nid_versao_update(movimentacao, ultimo_mov)

    movimentacao_nova = movimentacao.dup
    movimentacao_nova.version += 1
    movimentacao_nova.ativo = 1
    movimentacao_nova 
  end
  
  def carrega_combos 
    @tecnicos = Tecnico.all(:order => "nome")
    @modelos = Modelo.all(:order => "descricao")
    @versoes = Versao.all(:order => "descricao")
  end  
  
  def trata_params
    if (!params[:movimentacao].nil?) 
       params[:movimentacao][:data_movimentacao] = trata_data(params[:movimentacao][:data_movimentacao]) if params[:movimentacao][:data_movimentacao]
       params[:movimentacao][:data_entrada] = trata_data(params[:movimentacao][:data_entrada]) if params[:movimentacao][:data_entrada]
       params[:movimentacao][:data_relatorio] = trata_data(params[:movimentacao][:data_relatorio]) if params[:movimentacao][:data_relatorio]
       params[:movimentacao].delete_if{|k,v| v.blank?}
    end
  end
  
  def carrega_movimentacao
    @movimentacao = Movimentacao.find(params[:id])
  end
end
