//
//  OfertaItem.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 05/05/26.
//
import Foundation
import FirebaseFirestore

struct OfertaItem: Codable, Identifiable {
   @DocumentID var id: String?
    let produto: String
    let categoria: String
    let preco: Double
    let unidade: String
    let validade: String?
    let imagemURL: URL?

enum CodingKeys: String, CodingKey {

    case id
    case produto = "produto_nome"
    case categoria
    case preco
    case unidade
    case validade
    case imagemURL = "imagem_url"
    
}

}
