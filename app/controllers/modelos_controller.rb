# encoding : utf-8
class ModelosController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @modelos = Modelo.pesquisar(params[:modelo],params[:page])
    respond_with @modelos
  end

  def show
    @modelo = Modelo.find(params[:id])
    respond_with @modelo
  end

  def new
    @modelo = Modelo.new
    respond_with @modelo
  end

  def edit
    @modelo = Modelo.find(params[:id])
  end

  def create
    @modelo = Modelo.new(params[:modelo])
    
    if @modelo.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to modelos_path
    else
      render :action => :new 
    end
     
  end

  def update
    @modelo = Modelo.find(params[:id])

    if @modelo.update_attributes(params[:modelo])
      flash[:notice] = t('msg.update_sucess')
      redirect_to modelos_path
    else
      render :action => :edit
    end
end

  def destroy
    @modelo = Modelo.find(params[:id])
    @modelo.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to modelos_path
  end
  
  private

  def setar_classe_menu
    @class_modelo = 'active'  
  end
  
  
end
