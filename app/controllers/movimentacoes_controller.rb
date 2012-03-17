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
    @tecnicos = Tecnico.all
    @modelos = Modelo.all
    @versoes = Versao.all
    @movimentacao = Movimentacao.new
    respond_with @movimentacao
  end

  def edit
    @tecnicos = Tecnico.all
    @modelos = Modelo.all
    @versoes = Versao.all
    @movimentacao = Movimentacao.find(params[:id])
  end

  def create
    @movimentacao = Movimentacao.new(params[:movimentacao])
    
    if @movimentacao.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to movimentacoes_path
    else
      render :action => :new 
    end
     
  end

  def update
    @movimentacao = Movimentacao.find(params[:id])

    if @movimentacao.update_attributes(params[:movimentacao])
      flash[:notice] = t('msg.update_sucess')
      redirect_to movimentacoes_path
    else
      render :action => :edit
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
  
end
