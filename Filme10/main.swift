
import Foundation
import SwiftKuery

let utils = CommonUtils.sharedInstance

let filmes = Filmes ()
utils.criaTabela (filmes)
print("Tabela Filme Criada")

let elencos = Elencos()
_ = elencos.foreignKey(elencos.idfilme, references:
filmes.idFilme)
utils.criaTabela (elencos)
print("Tabela Elenco Criada")


