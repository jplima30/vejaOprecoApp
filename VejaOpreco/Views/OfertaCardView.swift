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
            // 1. Imagem do Produto (Ocupa as bordas superiores e laterais com altura expandida)
            ZStack {
                Color(.systemGray6).opacity(0.35)
                
                if let urlSegura = oferta.imagemURL {
                    AsyncImage(url: urlSegura) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 140)
                        case .success(let imagem):
                            imagem
                                .resizable()
                                .scaledToFit()
                                .frame(height: 140)
                                .padding(4)
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.gray.opacity(0.45))
                                .frame(height: 140)
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
                        .frame(height: 140)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            
            // 2. Informações da Oferta (Com padding interno confortável)
            VStack(alignment: .leading, spacing: 6) {
                // Preço e Unidade
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(oferta.preco, format: .currency(code: "BRL"))
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundStyle(Color.green)
                    
                    Text("/ \(oferta.unidade)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                
                // Nome do Produto (Altura simétrica fixa de 36pt para alinhamento em 2 linhas)
                Text(oferta.produto)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: 36, alignment: .topLeading)
                
                // Supermercado e Validade
                VStack(alignment: .leading, spacing: 3) {
                    Text(oferta.nomeSupermercadoExibicao)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.orange.opacity(0.12))
                        .clipShape(Capsule())
                        .lineLimit(1)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(size: 9))
                        Text(oferta.validade ?? "Oferta ativa")
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                }
                .frame(height: 38, alignment: .topLeading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 275)
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
                    validade: nil,
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
