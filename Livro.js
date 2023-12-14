class Livro {
  #nome;
  #preco;

  constructor(pNome, pPreco) {
    this.#nome = pNome;
    this.#preco = pPreco;
  }

  CalcularDesconto() {
    let desconto = this.#preco - 5.0;
    return desconto;
  }

  // Getter methods
  get Nome() { return this.#nome; }
  get Preco() { return this.#preco; }

  // Setter methods
  set Preco(pPreco) { 
    if (pPreco >= 1)
      this.#preco = pPreco;
    else
      console.log("Valor negativo");
  }

  set Nome(pNome) { this.#nome = pNome; }
}

let livro1 = new Livro('Sesinho', 12.9);
console.log(livro1.Nome);
console.log(livro1.Preco);
livro1.Preco = -1;
console.log(livro1.Preco);
console.log(livro1.CalcularDesconto());

let livro2 = new Livro('Algoritmo', 29.9);
console.log(livro2.Nome);
console.log(livro2.Preco);
console.log(livro2.CalcularDesconto());

let livro3 = new Livro('Banco de Dados', 39.9);
console.log(livro3.Nome);
console.log(livro3.Preco);
console.log(livro3.CalcularDesconto());

var carrinho=[];
carrinho.push(livro1);
carrinho.push(livro2);
carrinho.push(livro3);

console.log("Carrinho");
console.log(carrinho[0].Nome);
console.log(carrinho[0].CalcularDesconto());
console.log(carrinho[1].Nome);

console.log(carrinho[1].CalcularDesconto());

console.log( carrinho[2].Nome);
console.log( carrinho[2].CalcularDesconto());
