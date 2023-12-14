class Conta{
    #saldo;
    constructor(){
        this.#saldo = 0;
      
    }
    get Saldo(){return this.#saldo;}
    set Saldo(pSaldo)
    {this.#saldo = pSaldo;}

    imprimir(){
        return "Saldo: " + this.#saldo
    }

}

class Corrente extends Conta {
#limite;
constructor(pLimite){
    super();
    this.#limite = pLimite;
    
}

get Limite() {return this.#limite;}
set Limite(pLimite)
{this.#limite = pLimite;}

 imprimir() { 
     return super.imprimir() + "\nLimite: " + this.#limite;
    }
  
}

var objeto_corrente = new Corrente(300);
objeto_corrente.Saldo = 1000;
console.log("Saldo:",objeto_corrente.Saldo);
console.log(objeto_corrente.imprimir());