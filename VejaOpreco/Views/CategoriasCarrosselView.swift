//
//  CategoriasCarrosselView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 14/08/26.
//

import SwiftUI

struct CategoriasCarrosselView: View {
    @Binding var categoriaSelecionada: OfertaItem.Categoria
    @Namespace private var animationNamespace
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(OfertaItem.Categoria.allCases, id: \.self) { categoria in
                    CategoriaItemView(
                        categoria: categoria,
                        estaSelecionada: categoriaSelecionada == categoria,
                        namespace: animationNamespace
                    ) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.72)) {
                            categoriaSelecionada = categoria
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

private struct CategoriasCarrosselPreviewContainer: View {
    @State private var selecionada: OfertaItem.Categoria = .alimentos
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            VStack {
                CategoriasCarrosselView(categoriaSelecionada: $selecionada)
                
                Text("Categoria selecionada: \(selecionada.nomeExibicao)")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    CategoriasCarrosselPreviewContainer()
}
