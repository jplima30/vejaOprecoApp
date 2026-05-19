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
        NavigationStack {
            List(viewModel.ofertas) { oferta in
                HStack (alignment: .center) {
                    if let urlSegura = oferta.imagemURL {
                        AsyncImage(url: urlSegura) { imagem in
                            imagem
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        placeholder: {
                            ProgressView()
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame( width: 60, height: 60)
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(oferta.produto).font(.headline)
                        Text("R$\(oferta.preco)").foregroundStyle(.green)
                    }
                }
            }
            .navigationTitle("Ofertas do Dia")
            .onAppear {
                viewModel.carregarOfertas()
            }
            
        }
    }
}
#Preview {
    ListaOfertasView()
}


