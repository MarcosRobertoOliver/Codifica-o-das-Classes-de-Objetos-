//
//  Utils.swift
//  Filme10
//
//  Created by Marcos Roberto De Oliveira on 14/12/23.
//

import Foundation
import SwiftKuery
import SwiftKueryMySQL

import Foundation
import SwiftKuery
import SwiftKueryMySQL

class CommonUtils {
    private var pool: ConnectionPool?
    private var connection: Connection?
    static let sharedInstance = CommonUtils()
    private init() {}

    private func getConnectionPool(characterSet: String? = nil) -> ConnectionPool {
        if let existingPool = pool {
            return existingPool
        }

        do {
            let connectionFile = #file.replacingOccurrences(of: "Utils.swift", with: "connection.json")
            let data = Data(referencing: try NSData(contentsOfFile: connectionFile))
            let json = try JSONSerialization.jsonObject(with: data) as? [String: String]

            guard let dictionary = json else {
                pool = nil
                print("Invalid format in connection.json: \(json ?? [:])")
                return pool!
            }

            let host = dictionary["host"] ?? "localhost"
            let username = dictionary["username"]
            let password = dictionary["password"]
            var port: Int? = nil
            if let portString = dictionary["port"] {
                port = Int(portString)
            }

            let randomBinary = arc4random_uniform(2)
            let poolOptions = ConnectionPoolOptions(initialCapacity: 1, maxCapacity: 1)

            if characterSet != nil || randomBinary == 0 {
                pool = MySQLConnection.createPool(host: host, user: username, password: password, database: dictionary["database"], port: port, characterSet: characterSet, poolOptions: poolOptions)
            } else {
                var urlString = "mysql://"
                if let username = username, let password = password {
                    urlString += "\(username):\(password)@"
                }
                urlString += "\(host)"

                if let port = port {
                    urlString += ":\(port)"
                }
                if let database = dictionary["database"] {
                    urlString += "/\(database)"
                }

                if let url = URL(string: urlString) {
                    pool = MySQLConnection.createPool(url: url, poolOptions: poolOptions)
                } else {
                    pool = nil
                    print("URL has an invalid format: \(urlString)")
                }
            }
        } catch {
            print("Error thrown")
            pool = nil
        }

        return pool!
    }

    func getConnection() -> Connection? {
        if let existingConnection = connection {
            return existingConnection
        }

        self.connection = nil

        getConnectionPool().getConnection { [weak self] connection, error in
            guard let self = self else { return }
            guard let connection = connection else {
                guard let error = error else {
                    print("Error connecting to the database: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                print("Error connecting to the database: \(error.localizedDescription)")
                return
            }

            self.connection = connection
        }

        return connection
    }

    func criaTabela(_ tabela: Table) {
        let thread = DispatchGroup()
        thread.enter()

        guard let con = getConnection() else {
            print("Sem conexao")
            return
        }

        tabela.create(connection: con) { result in
            if result.success {
                print("Falha ao criar a tabela \(tabela.nameInQuery)")
            }
            thread.leave()
        }

        thread.wait()
    }

    func executaQuery(_ query: Query) {
        let thread = DispatchGroup()
        thread.enter()

        if let connection = getConnection() {
            connection.execute(query: query) { result in
                var nomeQuery = String(describing: type(of: query))
                if nomeQuery == "Raw" {
                    nomeQuery = String(describing: query.self).split(separator: "\"")[1].split(separator: "")[0].capitalized
                }
                if let erro = result.asError {
                    print("\(nomeQuery), Falha de execucao: \(erro)")
                }
                thread.leave()
            }
        } else {
            print("Sem conexao")
            thread.leave()
        }

        thread.wait()
    }

    func executaSelect(_ query: Select, aoFinal: @escaping ([[Any?]]?) -> ()) {
        let thread = DispatchGroup()
        thread.enter()

        var registros = [[Any?]]()

        if let connection = getConnection() {
            connection.execute(query: query) { result in
                guard let dados = result.asResultSet else {
                    print("Não houve resultado da consulta")
                    return thread.leave()
                }

                dados.forEach { linha, error in
                    if let _linha = linha {
                        var colunas: [Any?] = [Any?]()
                        _linha.forEach { atributo in
                            colunas.append(atributo)
                        }
                        registros.append(colunas)
                    } else {
                        thread.leave()
                    }
                }
            }
        } else {
            print("Sem Conexao")
            thread.leave()
        }

        thread.wait()
        aoFinal(registros)
    }

    func removeTabela(_ tabela: Table) {
        executaQuery(tabela.drop())
    }
}
