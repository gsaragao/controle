# encoding : utf-8
class TecnicosController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @tecnicos = Tecnico.all
    respond_with @tecnicos
  end

  def show
    @tecnico = Tecnico.find(params[:id])
    respond_with @tecnico
  end

  def new
    @tecnico = Tecnico.new
    respond_with @tecnico
  end

  def edit
    @tecnico = Tecnico.find(params[:id])
  end

  def create
    @tecnico = Tecnico.new(params[:tecnico])
    
    if @tecnico.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to tecnicos_path
    else
      render :action => :new 
    end
     
  end

  def update
    @tecnico = Tecnico.find(params[:id])

    if @tecnico.update_attributes(params[:tecnico])
      flash[:notice] = t('msg.update_sucess')
      redirect_to tecnicos_path
    else
      render :action => :edit
    end
end

  def destroy
    @tecnico = Tecnico.find(params[:id])
    @tecnico.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to tecnicos_path
  end
  
  private

  def setar_classe_menu
    @class_tecnico = 'active'  
  end
  
  
end
