class Devolucao < ActiveRecord::Base
  belongs_to :movimentacao
  belongs_to :destino
  validates_presence_of :destino_id, :origem_id, :movimentacao_id, :data_devolucao
  self.per_page = 10
  attr_accessor :serie, :patrimonio, :tecnico, :versao, :modelo, :nfe_referencia, :ordem_servico  

  def self.pesquisar(dev, page)
    where(dev).paginate(:page => page).order("id desc")
  end
end