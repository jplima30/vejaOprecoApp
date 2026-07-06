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
                        AsyncImage(url: urlSegura) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            case .success(let imagem):
                                imagem
                                    .resizable()
                                    .scaledToFill() 
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.gray)
                    }
                        VStack(alignment: .leading) {
                            Text(oferta.produto).font(.headline)
                            Text(oferta.preco, format: .currency(code: "BRL")).foregroundStyle(.green)
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
