//
//  EditPortfolioView.swift
//  SwiftUIDemo
//
//  Created by claus on 07.09.21.
//

import SwiftUI

class EditPortfolioVM : ObservableObject {
    @Published var p : Portfolio
    var parentVM: TopLevelVM?
    
    init (portfolio:Portfolio) {
        self.p = portfolio
        
    }
    init(portfolio: Portfolio, parentVM: TopLevelVM) {
        self.p = portfolio
        self.parentVM = parentVM
    }
    func save() {
        parentVM!.updatePortfolio (portfolio:p)
        print ("SAVING")
    }
    func cancel() {
        
    }
    func delete() {
        parentVM!.deletePortfolio (id:p.id)
    }
    
}

struct EditPortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model : EditPortfolioVM
    var name = ""
    init(model: EditPortfolioVM) {
        self.model = model
        name = model.p.name
    }
    var body: some View {
        VStack {
            HStack {
            Text ("Name: ")
                Spacer()
                TextField ("Please enter", text: $model.p.name).padding()
            }.padding()
            Spacer()
            HStack {
                Button ("Cancel", action: { presentationMode.wrappedValue.dismiss() })
                Spacer()
                Button ("Delete", action: { model.delete() ;presentationMode.wrappedValue.dismiss() }).foregroundColor(.red)
                Spacer()
                Button ("Save", action: { model.save() ;presentationMode.wrappedValue.dismiss() })
            }.padding()
        }.textFieldStyle(RoundedBorderTextFieldStyle())
        
        .navigationTitle("Edit \(model.p.name)")
        
        }
}

struct CreateView_Previews: PreviewProvider {
    
    static var previews: some View {
        let p = Portfolio(name:"TestPortfolio")
        NavigationView {
            EditPortfolioView(model: EditPortfolioVM(portfolio: p))        }
    }
}
