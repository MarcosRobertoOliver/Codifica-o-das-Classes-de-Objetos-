//
//  Database.swift
//  Filme10
//
//  Created by Marcos Roberto De Oliveira on 13/12/23.
//

import Foundation
import SwiftKuery

class Filmes: Table{
    let tableName = "filme"
    let idFilme = Column ("idfilme", Int32.self,autoIncrement: true, primaryKey: true, notNull: true)
    let titulo = Column ("titulo", String.self,notNull: true)
    let genero = Column ("genero", String.self,notNull: true)
    let origem = Column ("origem", String.self,notNull: true)
    let duracao = Column ("duracao", Int32.self,notNull: true)
    let ano = Column ("ano", Int32.self,notNull: true)
    let capa = Column ("capa", String.self,notNull: true)
    let trailer = Column ("trailer", String.self,notNull: true)
}
class Elencos: Table{
    let tableName = "elenco"
    let idElenco = Column("idelenco", Int32.self,autoIncrement: true,primaryKey: true, notNull: true)
    let ator = Column ("ator", String.self,notNull: true)
    let idade = Column ("idade", Int32.self,notNull: true)
    let nacionalidade = Column ("nacionalidade", String.self,notNull: true)
    let idfilme = Column ("idfilme", Int32.self,notNull: true)}

