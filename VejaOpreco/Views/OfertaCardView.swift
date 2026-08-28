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
            // 1. Imagem do Produto em Formato Quadrado (175x175) com Sangria Total
            ZStack {
                // Fundo neutro suave da foto
                Color(.systemGray6).opacity(0.35)
                
                // Imagem do Produto (Expande-se em proporção 1:1 até as bordas)
                if let urlSegura = oferta.imagemURL {
                    AsyncImage(url: urlSegura) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .success(let imagem):
                            imagem
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(4)
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.gray.opacity(0.45))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                // Ribbon Vertical da Loja (Centralizado na borda esquerda com sutil translucidez)
                HStack {
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 5) {
                            // Círculo com a sigla corporativa da loja
                            Text(oferta.temaSupermercado.sigla)
                                .font(.system(size: 8, weight: .black))
                                .foregroundStyle(oferta.temaSupermercado.fundo)
                                .frame(width: 16, height: 16)
                                .background(Color.white)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(90))
                            
                            // Nome da loja na vertical
                            Text(oferta.nomeSupermercadoExibicao)
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(oferta.temaSupermercado.texto)
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3.5)
                        .background(oferta.temaSupermercado.fundo.opacity(0.90))
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 7,
                                bottomTrailingRadius: 7,
                                topTrailingRadius: 0
                            )
                        )
                        .shadow(color: .black.opacity(0.14), radius: 3, x: 1, y: 1)
                        .fixedSize()
                        .rotationEffect(.degrees(-90))
                        .frame(width: 24)
                        .padding(.leading, 2)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 175)
            
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
            .padding(.bottom, 6)
            
            Spacer(minLength: 0)
            
            // 3. Etiqueta de Validade no Rodapé da Vitrine (Abraçada na borda inferior do card, centralizada)
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
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3.5)
                    .background(Color.black.opacity(0.68))
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 7,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 7
                        )
                    )
                    .shadow(color: .black.opacity(0.12), radius: 2, y: -1)
                    
                    Spacer()
                }
            } else {
                Color.clear.frame(height: 16)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 295)
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
