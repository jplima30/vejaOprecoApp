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
