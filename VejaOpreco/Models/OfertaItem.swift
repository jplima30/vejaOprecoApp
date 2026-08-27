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
}

