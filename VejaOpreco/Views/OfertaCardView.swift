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
            // 1. Imagem do Produto com Etiquetas Abraçando as Bordas
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
                                .padding(6)
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
                
                // Camada de Etiquetas Integradas
                VStack(alignment: .leading, spacing: 8) {
                    // 1. Etiqueta de Validade (Abraçada no topo/centro)
                    if let validade = oferta.validade, !validade.isEmpty {
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 8))
                                Text(validade)
                                    .font(.system(size: 9, weight: .bold))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 9)
                            .padding(.vertical, 3.5)
                            .background(Color.black.opacity(0.65))
                            .clipShape(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 7,
                                    bottomTrailingRadius: 7,
                                    topTrailingRadius: 0
                                )
                            )
                            .shadow(color: .black.opacity(0.12), radius: 2, y: 1)
                            
                            Spacer()
                        }
                    } else {
                        // Espaço reservado para simetria
                        Color.clear.frame(height: 16)
                    }
                    
                    // 2. Etiqueta da Loja (Abraçada na lateral esquerda deitada na horizontal)
                    HStack(spacing: 0) {
                        HStack(spacing: 5) {
                            // Círculo com a sigla corporativa da loja
                            Text(oferta.temaSupermercado.sigla)
                                .font(.system(size: 8, weight: .black))
                                .foregroundStyle(oferta.temaSupermercado.fundo)
                                .frame(width: 17, height: 17)
                                .background(Color.white)
                                .clipShape(Circle())
                            
                            // Nome completo da loja na horizontal
                            Text(oferta.nomeSupermercadoExibicao)
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(oferta.temaSupermercado.texto)
                                .lineLimit(1)
                        }
                        .padding(.leading, 8)
                        .padding(.trailing, 10)
                        .padding(.vertical, 4)
                        .background(oferta.temaSupermercado.fundo)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 9,
                                topTrailingRadius: 9
                            )
                        )
                        .shadow(color: .black.opacity(0.12), radius: 3, x: 1, y: 1)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
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
                    loja: "Assaí Atacadista",
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
                    loja: "Supermercado Líder",
                    supermercadoId: "lider"
                )
            )
            .frame(width: 175)
        }
        .padding()
    }
}
