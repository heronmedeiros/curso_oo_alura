require_relative "produto"
require_relative "impresso"


class Livro < Produto
  attr_reader  :tipo, :possui_sobrecapa
  include Impresso

  def initialize(titulo, preco, ano_lancamento, possui_reimpressao, possui_sobrecapa, editora)
    super(titulo, preco, ano_lancamento, editora) # construtor de Produto
    @possui_reimpressao = possui_reimpressao
    @possui_sobrecapa = possui_sobrecapa
  end

  def matches?(query)
    ["livro", "impresso"].include?(query)
  end

  def possui_reimpressao?
    @possui_reimpressao
  end


end
