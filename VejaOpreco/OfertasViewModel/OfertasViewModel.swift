//
//  OfertasViewModel.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 10/05/26.
//

import Foundation
import Combine

class OfertasViewModel : ObservableObject {
    
    @Published var ofertas: [OfertaItem] = []
    
    private let servico = MockService()
    
    
    func carregarOfertas() {
        
       ofertas = servico.buscarOfertasDeTeste()
        
    }
    
}
