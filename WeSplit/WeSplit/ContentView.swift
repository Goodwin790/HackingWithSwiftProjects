//
//  ContentView.swift
//  WeSplit
//
//  Created by Сергей Киров on 22.05.2021.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages = [10, 15, 20, 25, 0]
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    var totalPerPerson: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var totalAmount: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    var body: some View {
        NavigationView{
        Form {
              Section {
                  TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                TextField("Number of people", text: $numberOfPeople)
                    .keyboardType(.numberPad)
                    
              }
            
            Section(header: Text("How much tip do you want to leave?")){
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0 ..< tipPercentages.count) {
                        Text("\(self.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text ("Total amount with tips")){
                Text("$\(totalAmount, specifier: "%.2f")")
              }
            
            Section(header:Text("Amount per person")){
                 Text("$\(totalPerPerson, specifier: "%.2f")")
             }
          
           
            }
        .navigationBarTitle("WeSplit")
        }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
