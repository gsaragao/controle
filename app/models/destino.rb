class Destino < ActiveRecord::Base
  validates_presence_of :descricao
  self.per_page = 10
   
   def self.pesquisar(mod, page)
      where(mod).paginate(:page => page).order("descricao")
   end
  
end
