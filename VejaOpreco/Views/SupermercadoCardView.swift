//
//  SupermercadoCardView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 26/08/26.
//

import SwiftUI

struct SupermercadoCardView: View {
    let supermercado: SupermercadoFiltro
    let estaSelecionado: Bool
    let aoTocar: () -> Void
    
    var body: some View {
        Button(action: aoTocar) {
            HStack(spacing: 10) {
                // Ícone / Logo do Supermercado
                ZStack {
                    Circle()
                        .fill(estaSelecionado ? Color.orange : Color.orange.opacity(0.12))
                        .frame(width: 38, height: 38)
                    
                    Image(systemName: "storefront.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(estaSelecionado ? Color.white : Color.orange)
                }
                
                // Informações da Loja e Validade
                VStack(alignment: .leading, spacing: 3) {
                    Text(supermercado.nome)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(estaSelecionado ? Color.orange : Color.primary)
                        .lineLimit(1)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 10))
                            .foregroundStyle(.secondary)
                        
                        Text(supermercado.periodoValidade)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .frame(minWidth: 150, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        estaSelecionado ? Color.orange : Color(.systemGray5),
                        lineWidth: estaSelecionado ? 2 : 1
                    )
            )
            .shadow(
                color: estaSelecionado ? Color.orange.opacity(0.2) : Color.black.opacity(0.04),
                radius: estaSelecionado ? 6 : 4,
                x: 0,
                y: 2
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color(.systemGray6).ignoresSafeArea()
        
        HStack(spacing: 12) {
            SupermercadoCardView(
                supermercado: SupermercadoFiltro(
                    id: "assai",
                    nome: "Assaí Atacadista",
                    periodoValidade: "13 a 15 Abr"
                ),
                estaSelecionado: true,
                aoTocar: {}
            )
            
            SupermercadoCardView(
                supermercado: SupermercadoFiltro(
                    id: "lider",
                    nome: "Supermercado Líder",
                    periodoValidade: "12 a 18 Abr"
                ),
                estaSelecionado: false,
                aoTocar: {}
            )
        }
        .padding()
    }
}
