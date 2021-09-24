//
//  DetailView.swift
//  SwiftUIDemo
//
//  Created by claus on 07.09.21.
//

import SwiftUI

// MARK: Viewmodel
class DetailVM : ObservableObject {
    @Published var portfolio: Portfolio
    @Published var gotoEditor = false
    var parentVM: TopLevelVM?
    
    init(portfolio: Portfolio) {
        self.portfolio = portfolio
    }
    init (portfolio: Portfolio, parentVM: TopLevelVM) {
        self.portfolio = portfolio
        self.parentVM = parentVM
    }
 
    // MARK: -- Intents
    func save() {
        
    }
    func cancel() {}
    func edit() {
        gotoEditor = true
    }
   
    // MARK: -- Destinations

    func editViewDestination () -> EditPortfolioView {
        let editVM = EditPortfolioVM (portfolio: portfolio, parentVM: self.parentVM!)
            return EditPortfolioView (model:editVM)
        }
    // calculated values
    var totalVal : Double {
        get { portfolio.positions.reduce (0.0, {x,y in
                                            x + Double(y.count) * y.price}) }
    }
}

// MARK: - View
struct DetailView: View {
    
    @ObservedObject var model: DetailVM
    
    var body: some View {
        VStack (alignment: .leading) {
            
            HStack {
                Text ("Todays value:").bold()
                Text ("\(model.totalVal, specifier: "%.2f")")
                    .bold()
                    .frame (maxWidth:.infinity, alignment: .trailing)
                    
            }.padding()
                
                    Text("Positions:")
            .bold().padding()
                    HStack (spacing: 10){
                        Text ("Ticker").bold().frame (maxWidth: .infinity, alignment: .leading)
                        Text ("Name").bold().frame (maxWidth: .infinity, alignment: .center)
                        Text ("Count").bold().frame (maxWidth: .infinity, alignment: .trailing)
                        Text ("Price").bold().frame (maxWidth: .infinity, alignment: .trailing)
                        Text ("Value").bold().frame (maxWidth: .infinity, alignment: .trailing)
                    }.font(.system(size: 16)).padding().background(Color.yellow)
                    List (model.portfolio.positions, id:\.ticker) {position in
                        PositionView (position: position)
                    }
                    .listStyle(PlainListStyle())
                
            
            Spacer()
            NavigationLink(
                destination: model.editViewDestination(),
                isActive: $model.gotoEditor) {
                Button (action: {model.edit()}, label: {Text("Edit")})
                .padding().frame(maxWidth:.infinity, alignment: .center)
            }
            
        }.background(Color.yellow).padding()
        
        .navigationTitle("\(model.portfolio.name)")
    }
}

// MARK: - PositionView

struct PositionView : View {
    var position: Position
    
    var body: some View {
        HStack (spacing:10) {
            Text ("\(position.ticker)").bold().frame(maxWidth: .infinity,  alignment: .leading)
            Text ("\(position.name)").italic().frame(maxWidth: .infinity, alignment: .center)
            Text ("\(position.count)").frame(maxWidth: .infinity, alignment: .trailing)
            Text ("\(position.price, specifier: "%.2f")").frame (maxWidth: .infinity, alignment: .trailing)
            Text ("\(position.value, specifier: "%.2f")").frame (maxWidth: .infinity, alignment: .trailing)
        }.font(.system(size: 12))
    }
}


let p : Portfolio = Portfolio (name: "Testportfolio", positions: [Position (ticker: "NESN", name: "Nestle", count: 5, price: 131.5),
                                                                  Position (ticker: "ZURN", name: "Zurich", count: 20, price: 400)])

// MARK: - Preview
struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            DetailView(model: DetailVM(portfolio:p))
        }
    }
}
