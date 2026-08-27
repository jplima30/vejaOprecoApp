//
//  ListaOfertasView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 11/05/26.
//

import SwiftUI

struct ListaOfertasView: View {
    @StateObject var viewModel = OfertasViewModel()
    
    // Configuração da Grade em 2 Colunas Flexíveis
    private let colunasGrid = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
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
                
                // 2. Seletor de Supermercados e Validade das Ofertas
                if !viewModel.supermercadosDisponiveis.isEmpty {
                    SupermercadosCarrosselView(
                        supermercados: viewModel.supermercadosDisponiveis,
                        supermercadoSelecionadoId: $viewModel.supermercadoSelecionadoId
                    )
                    .background(Color(.systemGray6).opacity(0.55))
                    
                    Divider()
                }
                
                // 3. Vitrine de Ofertas em Grid de 2 Colunas ou Estado Vazio
                if viewModel.ofertasFiltradas.isEmpty {
                    ContentUnavailableView {
                        Label(
                            "Nenhuma oferta encontrada",
                            systemImage: viewModel.categoriaSelecionada.nomeIcone
                        )
                    } description: {
                        if viewModel.supermercadoSelecionadoId != nil {
                            Text("Não encontramos promoções ativas para o supermercado selecionado na categoria \(viewModel.categoriaSelecionada.nomeExibicao).")
                        } else {
                            Text("Não encontramos promoções ativas para esta categoria hoje. Experimente selecionar outra categoria acima.")
                        }
                    } actions: {
                        if viewModel.supermercadoSelecionadoId != nil {
                            Button("Ver Todas as Lojas") {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                    viewModel.supermercadoSelecionadoId = nil
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        } else {
                            Button("Recarregar Ofertas") {
                                viewModel.carregarOfertas()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVGrid(columns: colunasGrid, spacing: 12) {
                            ForEach(viewModel.ofertasFiltradas) { oferta in
                                OfertaCardView(oferta: oferta)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 24)
                    }
                    .background(Color(.systemGray6).opacity(0.4))
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
