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
            VStack(spacing: 0) {
                // 1. Carrossel de Categorias no Topo
                CategoriasCarrosselView(categoriaSelecionada: $viewModel.categoriaSelecionada)
                    .background(
                        LinearGradient(
                            colors: [Color.orange, Color.orange.opacity(0.9)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // 2. Lista de Ofertas Filtradas ou Estado Vazio
                if viewModel.ofertasFiltradas.isEmpty {
                    ContentUnavailableView {
                        Label(
                            "Nenhuma oferta em \(viewModel.categoriaSelecionada.nomeExibicao)",
                            systemImage: viewModel.categoriaSelecionada.nomeIcone
                        )
                    } description: {
                        Text("Não encontramos promoções ativas para esta categoria hoje. Experimente selecionar outra categoria acima.")
                    } actions: {
                        Button("Recarregar Ofertas") {
                            viewModel.carregarOfertas()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List(viewModel.ofertasFiltradas) { oferta in
                        HStack(spacing: 12) {
                            // Imagem do Produto
                            if let urlSegura = oferta.imagemURL {
                                AsyncImage(url: urlSegura) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 70, height: 70)
                                    case .success(let imagem):
                                        imagem
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    case .failure(_):
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .frame(width: 70, height: 70)
                                            .foregroundStyle(.gray.opacity(0.6))
                                            .background(Color(.systemGray6))
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(.gray.opacity(0.6))
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                            // Informações da Oferta
                            VStack(alignment: .leading, spacing: 4) {
                                Text(oferta.produto)
                                    .font(.headline)
                                    .lineLimit(2)
                                
                                HStack(spacing: 6) {
                                    Text(oferta.preco, format: .currency(code: "BRL"))
                                        .font(.title3.bold())
                                        .foregroundStyle(.green)
                                    
                                    Text("/ \(oferta.unidade)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                HStack(spacing: 8) {
                                    if let loja = oferta.loja {
                                        Text(loja)
                                            .font(.caption.bold())
                                            .foregroundStyle(.orange)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 2)
                                            .background(Color.orange.opacity(0.12))
                                            .clipShape(Capsule())
                                    }
                                    
                                    if let validade = oferta.validade {
                                        Text(validade)
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.carregarOfertas()
                    }
                }
            }
            .navigationTitle("Veja O Preço")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.ofertas.isEmpty {
                    viewModel.carregarOfertas()
                }
            }
        }
    }
}

#Preview {
    ListaOfertasView()
}
