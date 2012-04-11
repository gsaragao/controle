# encoding: UTF-8
class Retirada < ActiveRecord::Base
  belongs_to :versao
  belongs_to :modelo
  belongs_to :tecnico
  belongs_to :movimentacao
  self.per_page = 5
  validates_presence_of :os_saida, :serie, :patrimonio
  
   def self.pesquisar(mov, page)
      where(mov).paginate(:page => page).order("id desc")
   end
   
end
