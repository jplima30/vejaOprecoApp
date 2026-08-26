//
//  CategoriaItemView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 14/08/26.
//

import SwiftUI

struct CategoriaItemView: View {
    let categoria: OfertaItem.Categoria
    let estaSelecionada: Bool
    var namespace: Namespace.ID? = nil
    let aoTocar: () -> Void
    
    var body: some View {
        Button(action: aoTocar) {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(estaSelecionada ? Color(red: 0.98, green: 0.78, blue: 0.31) : Color.white.opacity(0.35))
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: categoria.nomeIcone)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(estaSelecionada ? Color.orange : Color.white)
                }
                
                Text(categoria.nomeExibicao)
                    .font(.system(size: 11, weight: estaSelecionada ? .bold : .medium))
                    .foregroundStyle(estaSelecionada ? Color.black.opacity(0.85) : Color.white.opacity(0.95))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: 28)
            }
            .frame(width: 74)
            .padding(.horizontal, 4)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background {
                if estaSelecionada {
                    if let namespace = namespace {
                        Capsule()
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            .matchedGeometryEffect(id: "CAPSULA_CATEGORIA", in: namespace)
                    } else {
                        Capsule()
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.orange.ignoresSafeArea()
        
        HStack(spacing: 8) {
            CategoriaItemView(
                categoria: .alimentos,
                estaSelecionada: false,
                aoTocar: {}
            )
            
            CategoriaItemView(
                categoria: .friosLaticinios,
                estaSelecionada: true,
                aoTocar: {}
            )
            
            CategoriaItemView(
                categoria: .carnes,
                estaSelecionada: false,
                aoTocar: {}
            )
            
            CategoriaItemView(
                categoria: .limpeza,
                estaSelecionada: false,
                aoTocar: {}
            )
        }
        .padding()
    }
}
