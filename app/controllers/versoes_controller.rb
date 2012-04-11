# encoding : utf-8
class VersoesController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @versoes = Versao.pesquisar(params[:versao],params[:page])
    respond_with @versoes
  end

  def show
    @versao = Versao.find(params[:id])
    respond_with @versao
  end

  def new
    @versao = Versao.new
    respond_with @versao
  end

  def edit
    @versao = Versao.find(params[:id])
  end

  def create
    @versao = Versao.new(params[:versao])
    
    if @versao.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to versoes_path
    else
      render :action => :new 
    end
     
  end

  def update
    @versao = Versao.find(params[:id])

    if @versao.update_attributes(params[:versao])
      flash[:notice] = t('msg.update_sucess')
      redirect_to versoes_path
    else
      render :action => :edit
    end
end

  def destroy
    @versao = Versao.find(params[:id])
    @versao.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to versoes_path
  end
  
  private

  def setar_classe_menu
    @class_versao = 'active'  
  end
  
  
end
