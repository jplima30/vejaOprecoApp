//
//  VejaOprecoApp.swift
//  VejaOpreco
//
//  Created by Joao Paulo Lima Silva on 03/05/26.
//

import SwiftUI
import Firebase

@main
struct VejaOprecoApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ListaOfertasView()
        }
    }
}
