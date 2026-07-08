//
//  OfertaItem.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 05/05/26.
//
import Foundation
import FirebaseFirestore

struct OfertaItem: Codable, Identifiable {
    @DocumentID var id: String?
    let produto: String
    let categoria: Categoria
    let preco: Double
    let unidade: String
    let validade: String?
    let imagemURL: URL?
    let loja: String?
    let supermercadoId: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case produto = "produto_nome"
        case categoria
        case preco
        case unidade
        case validade
        case imagemURL = "imagem_url"
        case loja
        case supermercadoId = "supermercado_id"
        
    }
    
    enum Categoria: String, Codable, CaseIterable {
        case alimentos = "ALIMENTOS"
        case bebidas = "BEBIDAS"
        case padaria = "PADARIA"
        case friosLaticinios = "FRIOS_LATICINIOS"
        case carnes = "CARNES"
        case hortifruti = "HORTFRUTI"
        case limpeza = "LIMPEZA"
        case higiene = "HIGIENE"
        case pet = "PET"
        case outros = "OUTROS"
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = Categoria(rawValue: rawValue.uppercased()) ?? .alimentos
        }
        
        // 3. A propriedade calculada para obter o Ícone do SF Symbols:
        var nomeIcone: String {
            switch self {
            case .alimentos: return "cart.fill"
            case .bebidas: return "cup.and.saucer.fill"
            case .padaria: return "croissant.fill"
            case .friosLaticinios: return "drop.fill" // ou cheese.fill
            case .carnes: return "drumstick.fill"
            case .hortifruti: return "leaf.fill"
            case .limpeza: return "spraybottle.fill"
            case .higiene: return "hand.sanitize.fill"
            case .pet: return "pawprint.fill"
            case .outros: return "ellipsis.circle.fill"
            }
        }
        // 4. A propriedade calculada para obter o Nome Amigável na tela:
        var nomeExibicao: String {
            switch self {
            case .alimentos: return "Alimentos"
            case .bebidas: return "Bebidas"
            case .padaria: return "Padaria"
            case .friosLaticinios: return "Frios & Laticínios"
            case .carnes: return "Carnes"
            case .hortifruti: return "Hortifrúti"
            case .limpeza: return "Limpeza"
            case .higiene: return "Higiene"
            case .pet: return "Pet"
            case .outros: return "Outros"
            }
        }
    }
}
