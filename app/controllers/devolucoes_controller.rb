# encoding : utf-8
class DevolucoesController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :trata_params, :only => [:index]
  before_filter :carrega_devolucao , :only => [:show, :edit, :update, :destroy]

    def index
      @destinos = Destino.all(:order => 'descricao')
      @devolucao = Devolucao.new(params[:devolucao])
      @devolucoes = Devolucao.pesquisar(params[:devolucao],params[:page])
      respond_with @devolucoes
    end

    def show
      respond_with @devolucao
    end

    def new
      @destinos = Destino.all(:order => 'descricao')
      @devolucao = Devolucao.new
      @devolucao.data_devolucao = Date.today
      respond_with @devolucao
    end

    def edit
      @destinos = Destino.all(:order => 'descricao')
    end

    def create
      @devolucao = Devolucao.new(params[:devolucao])

      if @devolucao.save
        flash[:notice] = t('msg.create_sucess')
        redirect_to devolucoes_path
      else 
        @destinos = Destino.all(:order => 'descricao')
        render :action => :new 
      end

    end

    def update
      if @devolucao.update_attributes(params[:devolucao])
        flash[:notice] = t('msg.update_sucess')
        redirect_to devolucoes_path
      else
        @destinos = Destino.all(:order => 'descricao')
        render :action => :edit
      end
    end

    def destroy
      @devolucao.destroy
      flash[:notice] = t('msg.destroy_sucess')
      redirect_to devolucoes_path
    end

    private

    def setar_classe_menu
      @class_devolucao = 'active'  
    end

    def carrega_devolucao
      @devolucao = Devolucao.find(params[:id])
    end

    def trata_params
      if (!params[:devolucao].nil?) 
         params[:devolucao][:data_devolucao] = trata_data(params[:devolucao][:data_devolucao]) if params[:devolucao][:data_devolucao]
         params[:devolucao].delete_if{|k,v| v.blank?}
      end
    end
end
