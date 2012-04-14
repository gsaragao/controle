module EnderecosHelper
  
  def ori_des(vlr)
     (vlr.to_s==Endereco::ORIGEM) ? "Origem" : "Destino"
  end
end
