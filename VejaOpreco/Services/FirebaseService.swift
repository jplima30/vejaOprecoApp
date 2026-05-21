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
    let db = Firestore.firestore()
    
    func buscarProdutos() async throws -> [OfertaItem] {
        try await db.collection("ofertas").getDocuments()
    }
    
}
