//
//  FirebaseService.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 18/05/26.
//

import Foundation
import Firebase

protocol OfertaServiceProtocol {
    func buscarProdutos() async throws -> [OfertaItem]
    
}

struct FirebaseService: OfertaServiceProtocol {
    func buscarProdutos() async throws -> [OfertaItem] {
        return []
    }
    
}

