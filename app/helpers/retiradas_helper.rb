module RetiradasHelper
  
  def ext_int(vlr)
     (vlr.to_s==Retirada::INTERNA) ? "Interna" : "Externa"
  end
  
end
