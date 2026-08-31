//
//  OfertaDetalheView.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 27/08/26.
//

import SwiftUI

struct OfertaDetalheView: View {
    let oferta: OfertaItem
    @Environment(\.dismiss) private var dismiss
    @State private var idCopiado: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 1. Container da Foto Expandida
                    ZStack(alignment: .bottomTrailing) {
                        // Fundo neutro com borda suave
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6).opacity(0.6))
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                        
                        // Imagem do Produto Expandida
                        if let urlSegura = oferta.imagemURL {
                            AsyncImage(url: urlSegura) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 300)
                                case .success(let imagem):
                                    imagem
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 300)
                                case .failure(_):
                                    VStack(spacing: 8) {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundStyle(.gray.opacity(0.5))
                                        Text("Foto indisponível")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    .frame(height: 300)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            VStack(spacing: 8) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.gray.opacity(0.5))
                                Text("Sem foto cadastrada")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(height: 300)
                        }
                        
                        // Badge Técnico de Resolução (Para inspecionar a qualidade real)
                        HStack(spacing: 4) {
                            Image(systemName: "camera.viewfinder")
                                .font(.system(size: 11, weight: .bold))
                            Text("200 × 200 px (Firebase)")
                                .font(.system(size: 11, weight: .semibold))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Capsule())
                        .padding(12)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(oferta.temaSupermercado.fundo.opacity(0.3), lineWidth: 1.5)
                    )
                    
                    // 2. Preço e Unidade em Destaque
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text(oferta.preco, format: .currency(code: "BRL"))
                                .font(.system(size: 34, weight: .heavy))
                                .foregroundStyle(Color.green)
                            
                            Text("/ \(oferta.unidade)")
                                .font(.title3.weight(.medium))
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            // Pílula da Marca
                            HStack(spacing: 5) {
                                Text(oferta.temaSupermercado.sigla)
                                    .font(.system(size: 9, weight: .black))
                                    .foregroundStyle(oferta.temaSupermercado.fundo)
                                    .frame(width: 18, height: 18)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                
                                Text(oferta.nomeSupermercadoExibicao)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(oferta.temaSupermercado.texto)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(oferta.temaSupermercado.fundo)
                            .clipShape(Capsule())
                        }
                        
                        // Nome Completo do Produto
                        Text(oferta.produto)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    // 3. Ficha Técnica / Metadados
                    VStack(spacing: 12) {
                        // Supermercado
                        HStack {
                            Label("Supermercado", systemImage: "storefront")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(oferta.nomeSupermercadoExibicao)
                                .fontWeight(.semibold)
                        }
                        
                        // Validade
                        if let validade = oferta.validade, !validade.isEmpty {
                            HStack {
                                Label("Validade da Oferta", systemImage: "clock")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(validade)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.orange)
                            }
                        }
                        
                        // Categoria
                        HStack {
                            Label("Categoria", systemImage: oferta.categoria.nomeIcone)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(oferta.categoria.nomeExibicao)
                                .fontWeight(.semibold)
                        }
                        
                        // ID do Produto (Canônico do Catálogo) com botão de cópia rápida
                        if let prodId = oferta.produtoId ?? oferta.id, !prodId.isEmpty {
                            HStack {
                                Label("Produto ID", systemImage: "tag")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Button {
                                    UIPasteboard.general.string = prodId
                                    UIPasteboard.general.setValue(prodId, forPasteboardType: "public.plain-text")
                                    let generator = UINotificationFeedbackGenerator()
                                    generator.notificationOccurred(.success)
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        idCopiado = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            idCopiado = false
                                        }
                                    }
                                } label: {
                                    HStack(spacing: 6) {
                                        Text(prodId)
                                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                                            .foregroundStyle(idCopiado ? Color.green : Color.primary)
                                            .lineLimit(1)
                                            .truncationMode(.middle)
                                            .textSelection(.enabled)
                                        
                                        Image(systemName: idCopiado ? "checkmark.circle.fill" : "doc.on.doc")
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundStyle(idCopiado ? Color.green : Color.accentColor)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 5)
                                    .background(idCopiado ? Color.green.opacity(0.15) : Color(.systemGray5).opacity(0.8))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                .contextMenu {
                                    Button {
                                        UIPasteboard.general.string = prodId
                                    } label: {
                                        Label("Copiar ID do Produto", systemImage: "doc.on.doc")
                                    }
                                }
                            }
                        }
                    }
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemGray6).opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    // 4. Painel de Auditoria Visual
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Diagnóstico de Resolução", systemImage: "info.circle.fill")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.blue)
                        
                        Text("Esta imagem foi extraída pelo backend em 200×200 px (JPEG ~7 KB). Observe a nitidez dos detalhes e dos textos da embalagem quando exibida em escala ampliada nesta tela de detalhes.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
            .navigationTitle("Detalhes da Oferta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    OfertaDetalheView(
        oferta: OfertaItem(
            id: "1",
            produtoId: "leite-condensado-piracanjuba-395g",
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
}
