//
//  OfertasViewModel.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 10/05/26.
//

import Foundation
import Combine

@MainActor
class OfertasViewModel : ObservableObject {
    
    @Published var ofertas: [OfertaItem] = []
    
    private let servico = FirebaseService()
    
    
    func carregarOfertas() {
        Task {
            do {
                ofertas = try await servico.buscarProdutos()
                
            } catch {
                print("Erro ao buscar s ofertas: \(error)")
            }
        }
    }
}
