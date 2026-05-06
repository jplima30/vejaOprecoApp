//
//  OfertaItem.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 05/05/26.
//
import Foundation

struct OfertaItem: Codable, Identifiable {
    let id: String
    let produto: String
    let categoria: String
    let preco: Double
    let unidade: String
    let validade: String
    let imagem: URL
}
