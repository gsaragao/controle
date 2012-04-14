# encoding : utf-8
class EnderecosController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @enderecos = Endereco.pesquisar(params[:endereco],params[:page])
    respond_with @enderecos
  end

  def show
    @endereco = Endereco.find(params[:id])
    respond_with @endereco
  end

  def new
    @endereco = Endereco.new
    @endereco.tipo = Endereco::ORIGEM
    respond_with @endereco
  end

  def edit
    @endereco = Endereco.find(params[:id])
  end

  def create
    @endereco = Endereco.new(params[:endereco])
    
    if @endereco.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to enderecos_path
    else
      render :action => :new 
    end
     
  end

  def update
    @endereco = Endereco.find(params[:id])

    if @endereco.update_attributes(params[:endereco])
      flash[:notice] = t('msg.update_sucess')
      redirect_to enderecos_path
    else
      render :action => :edit
    end
  end

  def destroy
    @endereco = Endereco.find(params[:id])
    @endereco.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to enderecos_path
  end
  
  private

  def setar_classe_menu
    @class_endereco = 'active'  
  end
  
end
