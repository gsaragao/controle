# encoding : utf-8
class DestinosController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @destinos = Destino.all
    respond_with @destinos
  end

  def show
    @destino = Destino.find(params[:id])
    respond_with @destino
  end

  def new
    @destino = Destino.new
    respond_with @destino
  end

  def edit
    @destino = Destino.find(params[:id])
  end

  def create
    @destino = Destino.new(params[:destino])
    
    if @destino.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to destinos_path
    else
      render :action => :new 
    end
     
  end

  def update
    @destino = Destino.find(params[:id])

    if @destino.update_attributes(params[:destino])
      flash[:notice] = t('msg.update_sucess')
      redirect_to destinos_path
    else
      render :action => :edit
    end
  end

  def destroy
    @destino = Destino.find(params[:id])
    @destino.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to destinos_path
  end
  
  private

  def setar_classe_menu
    @class_destino = 'active'  
  end
  
end
