//
//  MockService.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 06/05/26.
//

import Foundation

<<<<<<< HEAD
=======
class MockService {
    static let shared = MockService()
    
    private init() {}
    
    func fetchMockOfertas() -> [OfertaItem] {
        return [
            OfertaItem(
                id: "1",
                produto: "Café Melitta 500g",
                categoria: "Mercearia",
                preco: 18.90,
                unidade: "Un",
                validade: "10/10/2026",
                imagem: URL(string: "https://example.com/cafe.jpg")!
            ),
            OfertaItem(
                id: "2",
                produto: "Açúcar União 1kg",
                categoria: "Mercearia",
                preco: 4.50,
                unidade: "Un",
                validade: "20/12/2026",
                imagem: URL(string: "https://example.com/acucar.jpg")!
            ),
            OfertaItem(
                id: "3",
                produto: "Detergente Ypê 500ml",
                categoria: "Limpeza",
                preco: 2.29,
                unidade: "Un",
                validade: "15/05/2027",
                imagem: URL(string: "https://example.com/detergente.jpg")!
            ),
            OfertaItem(
                id: "4",
                produto: "Sabão em Pó Omo 1.6kg",
                categoria: "Limpeza",
                preco: 22.90,
                unidade: "Cx",
                validade: "01/01/2028",
                imagem: URL(string: "https://example.com/sabao.jpg")!
            )
        ]
    }
}
>>>>>>> 9335e138933f3b52a8d4c016155f2f74adb3b467
