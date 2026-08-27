//
//  OfertaCardView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 27/08/26.
//

import SwiftUI

struct OfertaCardView: View {
    let oferta: OfertaItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Imagem do Produto
            ZStack {
                Color(.systemGray6).opacity(0.4)
                
                if let urlSegura = oferta.imagemURL {
                    AsyncImage(url: urlSegura) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 120)
                        case .success(let imagem):
                            imagem
                                .resizable()
                                .scaledToFit()
                                .frame(height: 120)
                                .padding(6)
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .foregroundStyle(.gray.opacity(0.5))
                                .frame(height: 120)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(height: 120)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Preço e Unidade
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(oferta.preco, format: .currency(code: "BRL"))
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(Color.green)
                
                Text("/ \(oferta.unidade)")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            
            // Nome do Produto (Altura fixa para simetria na grade)
            Text(oferta.produto)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(height: 36, alignment: .topLeading)
            
            // Supermercado e Validade
            VStack(alignment: .leading, spacing: 3) {
                if let loja = oferta.loja {
                    Text(loja)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.orange.opacity(0.12))
                        .clipShape(Capsule())
                        .lineLimit(1)
                }
                
                if let validade = oferta.validade {
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(size: 9))
                        Text(validade)
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                }
            }
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ZStack {
        Color(.systemGray6).ignoresSafeArea()
        
        HStack(spacing: 12) {
            OfertaCardView(
                oferta: OfertaItem(
                    id: "1",
                    produto: "Leite Condensado Piracanjuba Semidesnatado 395g",
                    categoria: .alimentos,
                    preco: 4.89,
                    unidade: "un",
                    validade: "13 a 15 Abr",
                    imagemURL: nil,
                    loja: "Assaí",
                    supermercadoId: "assai"
                )
            )
            .frame(width: 170)
            
            OfertaCardView(
                oferta: OfertaItem(
                    id: "2",
                    produto: "Alcatra Bovina com Maminha",
                    categoria: .carnes,
                    preco: 36.90,
                    unidade: "kg",
                    validade: "12 a 18 Abr",
                    imagemURL: nil,
                    loja: "Líder",
                    supermercadoId: "lider"
                )
            )
            .frame(width: 170)
        }
        .padding()
    }
}
