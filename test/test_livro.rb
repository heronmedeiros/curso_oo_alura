require 'test/unit'
require './livro'

class LivroTest < Test::Unit::TestCase

  def setup
    @livro = Livro.new("Demonologista", 100, 2011, false)
    @livro_reimpressao = Livro.new("Demonologista", 30, 2005, true)
  end

  def test_attr_readers_of_livro
    assert_equal("Demonologista", @livro.titulo)
    # assert_equal(30, livro.preco)
    assert_equal(2011, @livro.ano_lancamento)
  end


  # Se o livro foi lançado em um ano anterior a 2006 e não possui reimpressões, dê 5% de desconto.
  def test_livro_anterior_a_2006_com_reimpressao

    assert_equal(27, @livro_reimpressao.preco)
  end

  # Se o livro foi lançado em um ano anterior a 2006 e possui reimpressões, dê 10% de desconto.
  def test_livro_anterior_a_2006_sem_reimpressao
    livro = Livro.new("Demonologista", 30, 2005, false)
    assert_equal(28.5, livro.preco)
  end

  # Se o livro foi lançado entre 2006 e 2010 - inclusive, dê 4% de desconto.
  def test_livro_posterior_a_2006
    livro = Livro.new("Demonologista", 100, 2007, false)
    assert_equal(96, livro.preco)
  end

  def test_livro_com_ano_2010
    livro = Livro.new("Demonologista", 100, 2010, false)
    assert_equal(96, livro.preco)
  end

  def test_livro_posterior_a_2010
    livro = Livro.new("Demonologista", 100, 2011, false)
    assert_equal(100, livro.preco)
  end

  def test_to_csv
    csv = @livro.to_csv
    assert_equal csv, "Demonologista, 2011, 100"
  end
end
