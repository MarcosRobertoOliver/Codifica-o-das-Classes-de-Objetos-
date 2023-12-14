class Livro {
    #autor;
    #preco;
    #editora;
    constructor(pAutor, pPreco, pEditora){
        this.#autor= pAutor;
        this.#preco= pPreco;
        this.#editora= pEditora;
    }
    calcularDesconto(){
        let desconto = this.#preco -5.0;
        return desconto;
    }
    get Editora() { this.#editora;}
    get Autor() { return this.#autor;}
    get Preco(){return this.#preco;}
    set Preco (pPreco) {
        if (pPreco>=1)
            this.#preco= pPreco;
        else
            console.log("Valor negativo")
    }
    set Autor(pAutor){ this.#autor = pAutor;}
    set Editora(pEditora){ this.#editora;}
}
class LivroInfantil extends Livro{
    #faixaetaria;
    constructor(pfaixa){ this.#faixaetaria = pfaixa;}
    get Faixa(){return this.#faixaetaria;}
    set Faixa(pfaixa){ this.#faixaetaria = pfaixa;}

}
class LivroTecnico extends Livro {
    #area;
    constructor(pArea){ this.#area = pArea;}
    get Area(){return this.#area;}
    set Area (pArea) { this.#area = pArea}
}