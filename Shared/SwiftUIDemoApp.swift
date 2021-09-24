//
//  SwiftUIDemoApp.swift
//  Shared
//
//  Created by claus on 07.09.21.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    var body: some Scene {
        let p = [
            Portfolio(id: 0, name: "Swiss",positions: [Position (ticker: "NESN", name: "Nestle", count: 5, price: 131.5),
                                                Position (ticker: "ZURN", name: "Zurich", count: 20, price: 400)]),
            Portfolio(id: 1, name:"International",positions: [Position (ticker: "NESN", name: "Nestle", count: 5, price: 131.5),
            Position (ticker: "ZURN", name: "Zurich", count: 20, price: 400)])]
        WindowGroup {
            TopLevelView(model: TopLevelVM(portfolios:p))
        }
    }
}
