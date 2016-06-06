require_relative "contador"

class Estoque
  attr_reader :livros

  def initialize
    @livros = []
    @vendas = []
    @livros.extend Contador
  end

  def <<(livro)
    @livros << livro if livro
    self
  end

  def vende(livro)
    @livros.delete livro if @livros.include?(livro)
    @vendas.push(livro)
  end

  def method_missing(name)
     matcher = name.to_s.match "(.+)_que_mais_vendeu_por_(.+)"

     if matcher
        tipo = matcher[1]
        campo = matcher[2].to_sym  #pois precisamos converter para simbolo
        que_mais_vendeu_por(tipo, &campo)
     else
        super
     end
  end

  def respond_to?(name)
    name.to_s.match ("(.+)_que_mais_vendeu_por_(.+)") || super
   end

  def que_mais_vendeu_por( tipo, &campo)
    por_tipo = @vendas.select {|produto| produto.matches?(tipo) }

    sorted = por_tipo.sort {|v1,v2|
       quantidade_de_vendas_por(v1, &campo) <=> quantidade_de_vendas_por(v2, &campo) }
    sorted.last

  end

  def quantidade_de_vendas_por produto, &campo
    @vendas.count { |venda| campo.call(venda) == campo.call(produto)}
  end

  def maximo_necessario
    @livros.maximo_necessario
  end

  def total
    @livros.size
  end

  def mais_baratos_que valor
    @livros.select do |livro|
      livro.preco < valor
    end
  end

  def exporta_csv
    @livros.inject("") do |csv, livro|
      csv += livro.to_csv
    end
  end
end
