import Foundation
import Combine

struct SupermercadoFiltro: Identifiable, Hashable {
    let id: String
    let nome: String
    let periodoValidade: String
}

@MainActor
class OfertasViewModel: ObservableObject {
    
    @Published var ofertas: [OfertaItem] = []
    @Published var categoriaSelecionada: OfertaItem.Categoria = .alimentos
    @Published var supermercadoSelecionadoId: String? = nil
    
    private let servico = FirebaseService()
    
    func carregarOfertas() {
        Task {
            do {
                ofertas = try await servico.buscarProdutos()
            } catch {
                print("Erro ao buscar as ofertas: \(error)")
            }
        }
    }
    
    var supermercadosDisponiveis: [SupermercadoFiltro] {
        var mapaMercados: [String: SupermercadoFiltro] = [:]
        
        for oferta in ofertas {
            guard let supId = oferta.supermercadoId, !supId.isEmpty else { continue }
            
            if mapaMercados[supId] == nil {
                let nomeLoja = oferta.nomeSupermercadoExibicao
                let validadeTexto = oferta.validade ?? "Oferta ativa"
                
                mapaMercados[supId] = SupermercadoFiltro(
                    id: supId,
                    nome: nomeLoja,
                    periodoValidade: validadeTexto
                )
            }
        }
        
        return Array(mapaMercados.values).sorted { $0.nome < $1.nome }
    }
    
    var ofertasFiltradas: [OfertaItem] {
        ofertas.filter { oferta in
            let bateCategoria = (oferta.categoria == categoriaSelecionada)
            let bateSupermercado = (supermercadoSelecionadoId == nil || oferta.supermercadoId == supermercadoSelecionadoId)
            return bateCategoria && bateSupermercado
        }
    }
}
