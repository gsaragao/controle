# encoding: UTF-8
class Retirada < ActiveRecord::Base
  belongs_to :versao
  belongs_to :modelo
  belongs_to :tecnico
  self.per_page = 10
  attr_accessor :operacoes
  validates_presence_of :tecnico_id, :os_saida, :serie, :patrimonio
  after_initialize :default_values  
  
  def default_values
    self.operacoes = {"Todos" => "", "Externa" => 0, "Interna" => 1}
  end
  
  INTERNA = '1'
  EXTERNA = '0'
  
   def self.pesquisar(ret, page)
      where(ret).paginate(:page => page).order("id desc")
   end
   
end
