# encoding: UTF-8
class Retirada < ActiveRecord::Base
  belongs_to :versao
  belongs_to :modelo
  belongs_to :tecnico
  belongs_to :destino
  belongs_to :movimentacao
  self.per_page = 10
  attr_accessor :operacoes, :serie_mov, :patrimonio_mov, :tecnico_mov, :versao_mov, :modelo_mov, :nfe_referencia_mov, 
  :ordem_servico_mov, :data_instalacao_mov
  validates_presence_of :destino_id, :os_saida
  validates_presence_of :movimentacao_id, :message => "deve ser preenchido.", :if => Proc.new { |retirada| retirada.operacao == Retirada::INTERNA }
  validates_presence_of :tecnico_id, :message => "deve ser preenchido.", :if => Proc.new { |retirada| retirada.operacao == Retirada::EXTERNA }
  validates_presence_of :serie, :message => "deve ser preenchido.", :if => Proc.new { |retirada| retirada.operacao == Retirada::EXTERNA }
  validates_presence_of :patrimonio, :message => "deve ser preenchido.", :if => Proc.new { |retirada| retirada.operacao == Retirada::EXTERNA }
  
  after_initialize :default_values  
  
  def default_values
    self.operacoes = {"Todos" => "", "Externa" => 0, "Interna" => 1}
  end
  
  INTERNA = 1
  EXTERNA = 0
  
   def self.pesquisar(ret, page)
      where(ret).paginate(:page => page).order("id desc")
   end
   
end