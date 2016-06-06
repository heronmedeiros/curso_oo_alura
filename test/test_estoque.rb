# encoding: utf-8
require 'test/unit'
require './estoque'
require './livro'


class TestEstoque < Test::Unit::TestCase
  def setup
    @estoque = Estoque.new
    @livro_algoritmos = Livro.new("Algoritmos", 100, 1998, true, "editora", "livro")
    @livro_arquitetura = Livro.new "Introdução À Arquitetura e Design de Software", 70.00, 2011, true, "editora", "livro"
    @livro_ruby = Livro.new("Programming Ruby", 100, 2004, true, "editora", "livro")
    @livro_programmer = Livro.new("The Pragmatic Programmer", 100, 1999, true, "editora", "ebook")
    @online_arquitetura = Livro.new("Introdução a Arquitetura e Design de Software", 50, 2012, true, "editora", "ebook")
    @revista_ruby = Livro.new("Revista Ruby", 100, 2004, true, "editora", "revista")
  end

  def test_attr_livros
    assert_equal @estoque.total, 0
  end

  def test_total_de_livros_adicionando_1
    @estoque<< @livro_algoritmos
    assert_equal @estoque.total, 1
  end

  def test_mais_baratos_que
    @estoque<< @livro_algoritmos
    @estoque<< @livro_arquitetura
    baratos = @estoque.mais_baratos_que 90
    assert_equal baratos, [@livro_arquitetura]
  end

  def test_adiciona_com_livro_nil
    @estoque<< nil
    assert_equal @estoque.total, 0
  end

  def test_exporta_csv
    @estoque<< @livro_algoritmos

    csv = "Algoritmos, 1998, 90.0"
    assert_equal(csv, @estoque.exporta_csv)
  end

  def test_maximo_necessario_continua_1_apos_remover_livro
    @estoque<< @livro_algoritmos
    @estoque.vende(@livro_algoritmos)
    assert_equal( 1 , @estoque.livros.maximo_necessario)
  end

  def test_maximo_necessario_continua_1_apos_remover_livro_inexistente
    @estoque<< @livro_arquitetura

    @estoque.vende(@livro_algoritmos)
    assert_equal( 1 , @estoque.livros.maximo_necessario)
  end

  def test_vendas_por_titulo
    @estoque << @livro_arquitetura << @livro_algoritmos
    @estoque << @livro_arquitetura << @livro_algoritmos
    @estoque.vende @livro_arquitetura
    @estoque.vende @livro_arquitetura


    qnt = @estoque.quantidade_de_vendas_por( @livro_arquitetura, &:titulo)
    assert_equal 2, qnt
  end

  def test_livro_que_mais_vendeu_por_titulo
    vende_muitos_livros
    assert_equal @livro_ruby.titulo, @estoque.que_mais_vendeu_por("livro", &:titulo).titulo

  end

  def test_method_missing
    @estoque<< @online_arquitetura
    @estoque.vende @online_arquitetura
    assert_equal @online_arquitetura.titulo, @estoque.ebook_que_mais_vendeu_por_titulo.titulo
    @estoque.livro_que_mais_vendeu_por_titulo
  end


  def test_livro_que_mais_vendeu_por
    vende_muitos_livros
    puts @estoque.livro_que_mais_vendeu_por_titulo.titulo
    puts @estoque.revista_que_mais_vendeu_por_titulo.titulo
  end

  private

  def vende_muitos_livros
    @estoque << @livro_algoritmos << @livro_algoritmos << @livro_ruby
    @estoque << @livro_programmer << @livro_arquitetura << @livro_ruby << @livro_ruby
    @estoque << @revista_ruby

    @estoque.vende @livro_ruby
    @estoque.vende @livro_ruby
    @estoque.vende @livro_ruby
    @estoque.vende @revista_ruby
    @estoque.vende @livro_algoritmos
    @estoque.vende @livro_algoritmos
  end
end
