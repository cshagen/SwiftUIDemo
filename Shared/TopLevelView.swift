//
//  ContentView.swift
//  Shared
//
//  Created by claus on 07.09.21.
//

import SwiftUI

class TopLevelVM : ObservableObject {
    @Published var portfolios : [Portfolio]
    
    // MARK: Constructors
    init(portfolios: [Portfolio]) {
        self.portfolios = portfolios
    }
    
    // MARK: Intents
    func addPortfolio () {
        let maxIndex = portfolios.reduce (0, {x,y in y.id > x ? y.id : x})
        portfolios.append (Portfolio(id: maxIndex + 1, name:"<New Portfolio>"))
        print ("\(portfolios.count)")
    }
    
    func updatePortfolio (portfolio: Portfolio) {
        self.portfolios = self.portfolios.map ({ return $0.id == portfolio.id ? portfolio : $0})
    }
    func deletePortfolio (id: Int) {
        let idx = self.portfolios.firstIndex (where: {$0.id == id})
        self.portfolios.remove (at: idx!)
    }
    
    // MARK: Destinations
    func detailViewDestination (portfolio: Portfolio) -> DetailView {
        let detailVM = DetailVM (portfolio: portfolio, parentVM: self)
        return DetailView (model:detailVM)
    }
}

struct TopLevelView: View {
    @ObservedObject var model : TopLevelVM
    @State var selectedPortfolio : Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                List (model.portfolios, id:\.name) {portfolio in
                    NavigationLink ("\(portfolio.name)",
                                    destination: model.detailViewDestination (portfolio:portfolio),
                                    tag: portfolio.id,
                                    selection: $selectedPortfolio)
                }
                .listStyle(PlainListStyle())
                
                Button (action: model.addPortfolio,
                        label: {Text("New Portfolio")})
                    .padding()
            }
            .padding()
            .navigationTitle ("Portfolios")
        }
    }
}

struct TopLevelView_Previews: PreviewProvider {
    static var previews: some View {
        let p =  [
                                Portfolio(id: 0, name: "Swiss"),
                                Portfolio(id: 1, name:"International")]
        TopLevelView(model:TopLevelVM (portfolios:p))
    }
}
