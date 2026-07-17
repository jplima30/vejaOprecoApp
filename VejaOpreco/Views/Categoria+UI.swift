import Foundation

extension OfertaItem.Categoria {
    var nomeIcone: String {
        switch self {
        case .alimentos: return "cart.fill"
        case .bebidas: return "cup.and.saucer.fill"
        case .padaria: return "croissant.fill"
        case .friosLaticinios: return "drop.fill"
        case .carnes: return "drumstick.fill"
        case .hortifruti: return "leaf.fill"
        case .limpeza: return "spraybottle.fill"
        case .higiene: return "hand.sanitize.fill"
        case .pet: return "pawprint.fill"
        case .outros: return "ellipsis.circle.fill"
        }
    }
    
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
