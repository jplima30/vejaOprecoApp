//
//  MockService.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 06/05/26.
//

import Foundation

class MockService {

    func buscarOfertasDeTeste() -> [OfertaItem]  {
        return [
            OfertaItem(id: "1", produto: "Arroz", categoria: "Mercearia", preco: 5.99, unidade: "1kg", validade: "10/10/2026", imagem: URL(string: "https://exemplo.com/arroz.png")!),
            OfertaItem(id: "2", produto: "Feijão", categoria: "Mercearia", preco: 8.99, unidade: "1kg", validade: "10/10/2026", imagem: URL(string: "https://exemplo.com/feijao.png")!)
        ]
    }
    
}
