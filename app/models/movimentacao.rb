# encoding: UTF-8
class Movimentacao < ActiveRecord::Base
  belongs_to :tecnico
  belongs_to :versao
  belongs_to :modelo
  has_attached_file :termo
  validates_presence_of :patrimonio, :tecnico_id, :data_entrada
  self.per_page = 10
  attr_accessor :lista_status, :lista_ativos, :acao
  after_initialize :default_values  
  
  def default_values
      self.lista_status = {"Good" => 1, "Instalado" => 2, "Bad"  => 3, "Stolen" => 4}
      self.lista_ativos = {"Todos" => "", "Sim" => 1, "Não"  => 0}
  end
  
  ACAO_UPDATE = '0'
  ACAO_MOVIMENTACAO = '1'
  GOOD = 1
  INSTALADO = 2
  BAD = 3
  STOLEN = 4
  
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
  
   def self.ultimo_nid
      @nid_max = maximum(:nid)
      where("nid = ?", @nid_max).first
   end 
   
   def self.ultima_versao(nid)
      @versao = maximum(:version, :conditions => ['nid = ?', nid])
      where("nid = ? and version = ?", nid, @versao).first
   end    
   
   def self.pesquisar(mov, page)
      where(mov).paginate(:page => page).order("id desc")
   end
   
   def self.valida_movimento(mov)
      where("serie = ? and patrimonio = ? and tecnico_id = ? and versao_id = ? and modelo_id = ?", 
      mov.serie, mov.patrimonio, mov.tecnico_id, mov.versao_id, mov.modelo_id )
   end
   
end
