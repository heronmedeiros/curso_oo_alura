class Conversor
  def string_para_alfanumerico nome
    nome.gsub /[^\w\s]/,''
  end

  def converter_numero_pra_reais valores
    valores.inject([]) do |ary, valor|
      valor_com_virgula =  valor.to_s.gsub /\.0/, ',00'

      ary << "R$#{valor_com_virgula}"
    end
  end
end
module Gerador
  private
  def gera_codigo
    "gerador original"
  end
end

class Cliente

  def gera_codigo
    "novo gerador"
  end

  include Gerador
end

puts Cliente.new.gera_codigo
