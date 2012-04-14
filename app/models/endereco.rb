class Endereco < ActiveRecord::Base
  validates_presence_of :descricao, :tipo
  self.per_page = 10
   
  ORIGEM = '1'
  DESTINO = '0' 
   
   def self.pesquisar(mod, page)
      where(mod).paginate(:page => page).order("descricao")
   end
   
   def self.pesquisar_tipo(tipo)
      where(:tipo => tipo).order("descricao")
   end
      
   
end
