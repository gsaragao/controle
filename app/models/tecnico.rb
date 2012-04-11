class Tecnico < ActiveRecord::Base
  validates_presence_of :nome
  self.per_page = 10
   
   def self.pesquisar(tec, page)
      where(tec).paginate(:page => page).order("nome")
   end
  
end
