//
//  AddView.swift
//  P7IExpense
//
//  Created by Сергей Киров on 27.09.2021.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    static let types = ["Business", "Personal"]
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name",text: $name)
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expence")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.amount){
                let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingAlert = true
                }
            })
        }
        .alert(isPresented: $showingAlert) { () -> Alert in
            Alert(title:Text("Entered Amount is  INCORRECT"), message: Text("For Amount you must enter Number for example: (1, 2, 3) not a LETTER \(alertMessage)"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
