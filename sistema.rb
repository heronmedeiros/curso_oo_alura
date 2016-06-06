require_relative "livro"
require_relative "estoque"

@livro = Livro.new("Demonologista", 100, 2011, false)
@livro_reimpressao = Livro.new("Demonologista", 30, 2005, true)
@estoque = Estoque.new
@livro_algoritmos = Livro.new("Algoritmos", 100, 1998, true)
@livro_arquitetura = Livro.new "Introdução À Arquitetura e Design de Software", 70.00, 2011, true

@estoque<< livro
def imprime_nota_fiscal()
  @livros.each do |livro|
    puts "Titulo: #{livro.titulo} - #{livro.preco}"
  end
end

def newsletter
  @livros.each do |livro|
    puts "Newsletter #{livro.titulo} - #{livro.preco}"
  end
end
