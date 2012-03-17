class Movimentacao < ActiveRecord::Base
  belongs_to :tecnico
  belongs_to :versao
  belongs_to :modelo
  
  attr_accessor :lista_status
  after_initialize :default_values  
  
  def default_values
      self.lista_status = {"Em Aberto" => 1, "Fechado" => 2, "Devolvido"  => 3, "Quebrado" => 4}
  end
  
  EM_ABERTO = 1
  FECHADO = 2
  DEVOLVIDO = 3
  QUEBRADO = 4
  
end
