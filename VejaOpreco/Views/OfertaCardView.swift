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
            // 1. Imagem do Produto com Pílulas Flutuantes nos Cantos
            ZStack(alignment: .top) {
                // Fundo neutro suave da foto
                Color(.systemGray6).opacity(0.35)
                
                // Imagem
                if let urlSegura = oferta.imagemURL {
                    AsyncImage(url: urlSegura) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 145)
                        case .success(let imagem):
                            imagem
                                .resizable()
                                .scaledToFit()
                                .frame(height: 145)
                                .padding(4)
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.gray.opacity(0.45))
                                .frame(height: 145)
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
                        .frame(height: 145)
                }
                
                // Pílulas nos Cantos Superiores
                HStack(alignment: .top) {
                    // Pílula da Loja (Canto Superior Esquerdo)
                    HStack(spacing: 5) {
                        // Círculo com a sigla corporativa da loja
                        Text(oferta.temaSupermercado.sigla)
                            .font(.system(size: 8, weight: .black))
                            .foregroundStyle(oferta.temaSupermercado.fundo)
                            .frame(width: 17, height: 17)
                            .background(Color.white)
                            .clipShape(Circle())
                        
                        Text(oferta.nomeSupermercadoExibicao)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(oferta.temaSupermercado.texto)
                            .lineLimit(1)
                    }
                    .padding(.leading, 3)
                    .padding(.trailing, 7)
                    .padding(.vertical, 3)
                    .background(oferta.temaSupermercado.fundo)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.15), radius: 3, y: 1)
                    
                    Spacer()
                    
                    // Pílula de Validade (Canto Superior Direito)
                    if let validade = oferta.validade, !validade.isEmpty {
                        HStack(spacing: 3) {
                            Image(systemName: "clock")
                                .font(.system(size: 8, weight: .bold))
                            Text(validade)
                                .font(.system(size: 9, weight: .semibold))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color.black.opacity(0.55))
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.15), radius: 3, y: 1)
                    }
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 145)
            
            // 2. Informações da Oferta (Preço real + Nome do produto)
            VStack(alignment: .leading, spacing: 6) {
                // Preço de Oferta em Verde Vibrante + Unidade
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(oferta.preco, format: .currency(code: "BRL"))
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundStyle(Color.green)
                    
                    Text("/ \(oferta.unidade)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                
                // Nome do Produto (Altura padronizada para simetria na grade)
                Text(oferta.produto)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: 36, alignment: .topLeading)
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(oferta.temaSupermercado.fundo.opacity(0.35), lineWidth: 1.5)
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
            .frame(width: 175)
            
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
            .frame(width: 175)
        }
        .padding()
    }
}
