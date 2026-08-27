import Foundation
import SwiftUI
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
    
    init(
        id: String? = nil,
        produto: String,
        categoria: Categoria,
        preco: Double,
        unidade: String,
        validade: String? = nil,
        imagemURL: URL? = nil,
        loja: String? = nil,
        supermercadoId: String? = nil
    ) {
        self.id = id
        self.produto = produto
        self.categoria = categoria
        self.preco = preco
        self.unidade = unidade
        self.validade = validade
        self.imagemURL = imagemURL
        self.loja = loja
        self.supermercadoId = supermercadoId
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
    }
}

extension OfertaItem {
    var nomeSupermercadoExibicao: String {
        // Se a loja não for um texto genérico de extração interna
        if let loja = loja, !loja.isEmpty,
           !loja.localizedCaseInsensitiveContains("visão"),
           !loja.localizedCaseInsensitiveContains("visao"),
           !loja.localizedCaseInsensitiveContains("extração"),
           !loja.localizedCaseInsensitiveContains("extracao") {
            return loja
        }
        
        // Mapeamento inteligente pelo supermercadoId
        guard let id = supermercadoId?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), !id.isEmpty else {
            return "Supermercado"
        }
        
        switch id {
        case "assai": return "Assaí"
        case "lider": return "Líder"
        case "formosa": return "Formosa"
        case "mateus", "mix_mateus", "mixmateus": return "Mix Mateus"
        case "nazare": return "Nazaré"
        case "armacao": return "Armação"
        case "prezunic": return "Prezunic"
        case "carrefour": return "Carrefour"
        default: return id.capitalized
        }
    }
    
    var temaSupermercado: (fundo: Color, texto: Color, sigla: String) {
        switch supermercadoId?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? "" {
        case "assai":
            // Azul Royal Assaí com texto branco e sigla AS
            return (Color(red: 0.05, green: 0.28, blue: 0.63), .white, "AS")
        case "lider":
            // Vermelho Líder com texto branco e sigla LD
            return (Color(red: 0.85, green: 0.12, blue: 0.15), .white, "LD")
        case "formosa":
            // Verde Formosa com texto branco e sigla FM
            return (Color(red: 0.08, green: 0.52, blue: 0.25), .white, "FM")
        case "mateus", "mix_mateus", "mixmateus":
            // Amarelo Ouro Mix Mateus com texto escuro e sigla MM
            return (Color(red: 0.98, green: 0.72, blue: 0.08), Color(red: 0.15, green: 0.15, blue: 0.15), "MM")
        case "nazare":
            // Verde Nazaré com texto branco e sigla NZ
            return (Color(red: 0.10, green: 0.45, blue: 0.30), .white, "NZ")
        default:
            let prefixo = String(nomeSupermercadoExibicao.prefix(2)).uppercased()
            return (Color.orange, .white, prefixo.isEmpty ? "VP" : prefixo)
        }
    }
}
