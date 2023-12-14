class Operacoes{
    constructor(){
        this.Imprimir();   
    }
    Somar(valorA, valorB)
    {
        return (valorA+valorB);
    }
    Somar(valorA, valorB, valorC)
    {
        return(valorA, valorB, valorC)
    }

    Subtrair(valorA, valorB)
    {
        let resposta = (valorA-valorB);
        return resposta;
    }
    Imprimir()
    {
        console.log("Este programa é uma Calculadora");
    }
}
var calculadora = new Operacoes();
var resposta = calculadora.Somar(4,1,1);

console.log( resposta);
resposta = calculadora.Subtrair(4,1);
console.log(resposta);
calculadora.Imprimir();