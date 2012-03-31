# encoding : utf-8
class MovimentacoesController < ApplicationController

  respond_to :html
  before_filter :trata_params, :only => [:index]
  
  def index
    @tecnicos = Tecnico.all
    @movimentacao = Movimentacao.new
    @movimentacoes = Movimentacao.pesquisar(params[:movimentacao],params[:page])
    respond_with @movimentacoes
  end

  def show
    @movimentacao = Movimentacao.find(params[:id])
    respond_with @movimentacao
  end

  def new
    carrega_combos
    @movimentacao = Movimentacao.new
    @movimentacao.status = Movimentacao::EM_ABERTO
    @movimentacao.data_movimentacao = Date.today
    respond_with @movimentacao
  end

  def edit
    carrega_combos
    @movimentacao = Movimentacao.find(params[:id])
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
    @movimentacao = Movimentacao.find(params[:id])
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
  end

  def destroy
    @movimentacao = Movimentacao.find(params[:id])
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
    @tecnicos = Tecnico.all
    @modelos = Modelo.all
    @versoes = Versao.all
  end  
  
  def trata_params
    if (!params[:movimentacao].nil?) 
       params[:movimentacao][:data_movimentacao] = trata_data(params[:movimentacao][:data_movimentacao])
       params[:movimentacao][:data_entrada] = trata_data(params[:movimentacao][:data_entrada])
       params[:movimentacao][:data_relatorio] = trata_data(params[:movimentacao][:data_relatorio])
       params[:movimentacao].delete_if{|k,v| v.blank?}
    end
  end
  
end
