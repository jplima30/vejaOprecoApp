//
//  SupermercadosCarrosselView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 26/08/26.
//

import SwiftUI

struct SupermercadosCarrosselView: View {
    let supermercados: [SupermercadoFiltro]
    @Binding var supermercadoSelecionadoId: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Cabeçalho da Seção
            HStack(spacing: 6) {
                Image(systemName: "calendar.badge.clock")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.orange)
                
                Text("VALIDADE DAS OFERTAS")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                if supermercadoSelecionadoId != nil {
                    Button("Ver Todas") {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            supermercadoSelecionadoId = nil
                        }
                    }
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.orange)
                }
            }
            .padding(.horizontal, 16)
            
            // Scroll Horizontal dos Cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    // Card "Todas as Lojas"
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            supermercadoSelecionadoId = nil
                        }
                    } label: {
                        HStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(supermercadoSelecionadoId == nil ? Color.orange : Color.orange.opacity(0.12))
                                    .frame(width: 38, height: 38)
                                
                                Image(systemName: "building.2.fill")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(supermercadoSelecionadoId == nil ? Color.white : Color.orange)
                            }
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Todas as Lojas")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(supermercadoSelecionadoId == nil ? Color.orange : Color.primary)
                                    .lineLimit(1)
                                
                                Text("Todas vigentes")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .frame(minWidth: 140, alignment: .leading)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    supermercadoSelecionadoId == nil ? Color.orange : Color(.systemGray5),
                                    lineWidth: supermercadoSelecionadoId == nil ? 2 : 1
                                )
                        )
                        .shadow(
                            color: supermercadoSelecionadoId == nil ? Color.orange.opacity(0.2) : Color.black.opacity(0.04),
                            radius: supermercadoSelecionadoId == nil ? 6 : 4,
                            x: 0,
                            y: 2
                        )
                    }
                    .buttonStyle(.plain)
                    
                    // Cards dos Supermercados Individuais
                    ForEach(supermercados) { mercado in
                        SupermercadoCardView(
                            supermercado: mercado,
                            estaSelecionado: supermercadoSelecionadoId == mercado.id
                        ) {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                if supermercadoSelecionadoId == mercado.id {
                                    supermercadoSelecionadoId = nil
                                } else {
                                    supermercadoSelecionadoId = mercado.id
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
        }
        .padding(.vertical, 6)
    }
}

private struct SupermercadosCarrosselPreviewContainer: View {
    @State private var selecionadoId: String? = "assai"
    
    let mockLojas = [
        SupermercadoFiltro(id: "assai", nome: "Assaí Atacadista", periodoValidade: "13 a 15 Abr"),
        SupermercadoFiltro(id: "lider", nome: "Supermercado Líder", periodoValidade: "12 a 18 Abr"),
        SupermercadoFiltro(id: "formosa", nome: "Grupo Formosa", periodoValidade: "14 a 20 Abr")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            
            VStack {
                SupermercadosCarrosselView(
                    supermercados: mockLojas,
                    supermercadoSelecionadoId: $selecionadoId
                )
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    SupermercadosCarrosselPreviewContainer()
}
