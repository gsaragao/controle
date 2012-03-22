# encoding : utf-8
class MovimentacoesController < ApplicationController

  respond_to :html

  def index
    @movimentacoes = Movimentacao.all
    respond_with @movimentacoes
  end

  def show
    @movimentacao = Movimentacao.find(params[:id])
    respond_with @movimentacao
  end

  def new
    carrega_combos
    @movimentacao = Movimentacao.new
    respond_with @movimentacao
  end

  def edit
    carrega_combos
    @movimentacao = Movimentacao.find(params[:id])
  end

  def create
    @movimentacao = Movimentacao.new(params[:movimentacao])
    @ultimo_mov = Movimentacao.ultima_versao(@movimentacao.nid)
    @movimentacao = seta_nid_versao(@movimentacao, @ultimo_mov)
    
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
    @ultimo_mov2 = Movimentacao.new(@ultimo_mov)
    @ultimo_mov2.ativo = 'N'
    @movimentacao = seta_nid_versao(@movimentacao, @ultimo_mov2)
      Movimentacao.transaction do
        if @movimentacao.save!(params[:movimentacao]) && @ultimo_mov2.save()
          flash[:notice] = t('msg.update_sucess')
          redirect_to movimentacoes_path
        else
          carrega_combos
          render :action => :edit
           raise ActiveRecord::Rollback, "DEU MERDDDDDDDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!"
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
  
  def seta_nid_versao(movimentacao, ultimo_mov)
    
    if (movimentacao.id == nil) 
      movimentacao.version = 1
      
      if (ultimo_mov != nil && ultimo_mov.nid > 0)
        movimentacao.nid =  ultimo_mov.nid + 1
      else
        movimentacao.nid = 1
      end  
      
    else
      movimentacao.version = movimentacao.version + 1
    end
    
    movimentacao_nova = movimentacao.dup
    movimentacao_nova.ativo = 'S'
    movimentacao_nova 
  end
  
  def carrega_combos 
    @tecnicos = Tecnico.all
    @modelos = Modelo.all
    @versoes = Versao.all
  end  
  
end
