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
        VStack(alignment: .leading, spacing: 0) {
            // 1. Imagem do Produto (Sangria total no topo e laterais)
            ZStack {
                Color(.systemGray6).opacity(0.35)
                
                if let urlSegura = oferta.imagemURL {
                    AsyncImage(url: urlSegura) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 135)
                        case .success(let imagem):
                            imagem
                                .resizable()
                                .scaledToFit()
                                .frame(height: 135)
                                .padding(4)
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.gray.opacity(0.45))
                                .frame(height: 135)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.gray.opacity(0.45))
                        .frame(height: 135)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 135)
            
            // 2. Informações da Oferta (Hierarquia visual com apelo promocional)
            VStack(alignment: .leading, spacing: 5) {
                // Pílula Personalizada com cores da Loja + Validade
                HStack(spacing: 4) {
                    Image(systemName: "storefront.fill")
                        .font(.system(size: 9))
                    
                    Text(oferta.nomeSupermercadoExibicao)
                        .font(.system(size: 10, weight: .bold))
                    
                    if let validade = oferta.validade {
                        Text("• \(validade)")
                            .font(.system(size: 9, weight: .medium))
                    }
                }
                .foregroundStyle(oferta.temaSupermercado.texto)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(oferta.temaSupermercado.fundo)
                .clipShape(Capsule())
                .lineLimit(1)
                
                // Preço Anterior Riscado ("De: R$ X,XX")
                HStack(spacing: 4) {
                    Text("De:")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(.secondary)
                    
                    Text(oferta.precoAnteriorExibicao, format: .currency(code: "BRL"))
                        .font(.system(size: 11, weight: .semibold))
                        .strikethrough(color: .secondary.opacity(0.8))
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 1)
                
                // Preço de Oferta em Destaque Verde + Unidade
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(oferta.preco, format: .currency(code: "BRL"))
                        .font(.system(size: 17, weight: .heavy))
                        .foregroundStyle(Color.green)
                    
                    Text("/ \(oferta.unidade)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                
                // Nome do Produto (Altura fixa de 34pt para simetria em 2 linhas)
                Text(oferta.produto)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: 34, alignment: .topLeading)
            }
            .padding(.horizontal, 10)
            .padding(.top, 8)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 295)
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
                    precoOriginal: 5.99,
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
                    precoOriginal: 44.90,
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
