//
//  ListaOfertasView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 11/05/26.
//

import SwiftUI

struct ListaOfertasView: View {
    @StateObject var viewModel = OfertasViewModel()
    var body: some View {
        List(viewModel.ofertas) { oferta in
            VStack(alignment: .leading) {
                Text(oferta.produto).font(.headline)
                Text("R$\(oferta.preco)").foregroundStyle(.green)
            }
            
        }
            .onAppear {
                viewModel.carregarOfertas()
            }
        
    }
}

 #Preview {
    ListaOfertasView()
}


