class Movimentacao < ActiveRecord::Base
  belongs_to :tecnico
  belongs_to :versao
  belongs_to :modelo
  has_attached_file :termo
  validates_presence_of :patrimonio
  validates_presence_of :tecnico_id
  
  attr_accessor :lista_status
  after_initialize :default_values  
  
  def default_values
      self.lista_status = {"Em Aberto" => 1, "Fechado" => 2, "Devolvido"  => 3, "Quebrado" => 4}
  end
  
  EM_ABERTO = 1
  FECHADO = 2
  DEVOLVIDO = 3
  QUEBRADO = 4
  
  validates_attachment_content_type :termo, 
                                    :content_type => ['image/jpg',
                                    'image/jpeg', 
                                    'image/png', 
                                    'image/gif',
                                    'image/pjpeg', 
                                    'image/x-png',
                                    'application/pdf',
                                    'application/rtf',
                                    'application/x-rtf', 
                                    'text/rtf',
                                    'text/richtext', 
                                    'application/doc',
                                    'application/x-soffice',
                                    'text/plain',
                                    'text/html',
                                    'text/xml',
                                    'application/vnd.oasis.opendocument.text',
                                    'application/msword',
                                    'application/mspowerpnt',
                                    'application/mspowerpoint',
                                    'application/ms-powerpoint',
                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.template',
                                    'application/vnd.ms-word.document.macroEnabled.12',
                                    'application/vnd.ms-word.template.macroEnabled.12',
                                    'application/vnd.ms-excel',
                                    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                    'application/vnd.openxmlformats-officedocument.spreadsheetml.template',
                                    'application/vnd.ms-excel.sheet.macroEnabled.12',
                                    'application/vnd.ms-excel.template.macroEnabled.12',
                                    'application/vnd.ms-excel.addin.macroEnabled.12',
                                    'application/vnd.ms-excel.sheet.binary.macroEnabled.12',
                                    'application/vnd.ms-powerpoint',
                                    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
                                    'application/vnd.openxmlformats-officedocument.presentationml.template',
                                    'application/vnd.openxmlformats-officedocument.presentationml.slideshow',
                                    'application/vnd.ms-powerpoint.addin.macroEnabled.12',
                                    'application/vnd.ms-powerpoint.presentation.macroEnabled.12',
                                    'application/vnd.ms-powerpoint.template.macroEnabled.12',
                                    'application/vnd.ms-powerpoint.slideshow.macroEnabled.12'],  
                                    :message => I18n.t('movimentacao.arquivo_valida.tipo')
  
   validates_attachment_size :termo, :less_than=> 2.megabytes,   
                                      :message => I18n.t('movimentacao.arquivo_valida.tamanho')
  
   def self.ultima_versao(nid)
     @versao = maximum(:version, :conditions => ['nid = ?', nid])
     where("nid = ? and version = ?", nid, @versao) 
   end   
end
