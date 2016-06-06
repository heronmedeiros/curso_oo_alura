require 'test/unit'
require './conversor'

class TestConversor < Test::Unit::TestCase
  def setup
    @conversor = Conversor.new
  end

  def test_remover_caracteres_estranhos
    nome = "Clean **Code!!!"
    nome_modificado = "Clean Code"
    assert_equal nome_modificado, @conversor.string_para_alfanumerico(nome)
  end

  def test_num_pra_reais
    precos = [30.0, 40.0, 70.0, 59.0, 12.23]
    assert_equal @conversor.converter_numero_pra_reais(precos), ["R$30,00", "R$40,00", "R$70,00", "R$59,00", "R$12,34"]
  end
end
