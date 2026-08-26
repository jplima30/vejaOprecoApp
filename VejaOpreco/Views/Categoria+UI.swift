import Foundation

extension OfertaItem.Categoria {
    var nomeIcone: String {
        switch self {
        case .alimentos: return "fork.knife"
        case .bebidas: return "cup.and.saucer.fill"
        case .padaria: return "birthday.cake.fill"
        case .friosLaticinios: return "drop.fill"
        case .carnes: return "flame.fill"
        case .hortifruti: return "leaf.fill"
        case .limpeza: return "dishwasher.fill"
        case .higiene: return "hands.and.sparkles.fill"
        case .pet: return "pawprint.fill"
        case .outros: return "ellipsis.circle.fill"
        }
    }
    
    var nomeExibicao: String {
        switch self {
        case .alimentos: return "Alimentos"
        case .bebidas: return "Bebidas"
        case .padaria: return "Padaria"
        case .friosLaticinios: return "Frios &\nLaticínios"
        case .carnes: return "Carnes"
        case .hortifruti: return "Hortifrúti"
        case .limpeza: return "Limpeza"
        case .higiene: return "Higiene"
        case .pet: return "Pet"
        case .outros: return "Outros"
        }
    }
}

