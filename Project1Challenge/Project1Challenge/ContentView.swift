//
//  ContentView.swift
//  Project1Challenge
//
//  Created by Сергей Киров on 02.06.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfGraduses = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    let graduses = [ "Celsius", "Fahrenheit", "Kelvin"]
    
    var converter: Double {
        let number = Double(numberOfGraduses) ?? 0
        let unitTemperature = [ UnitTemperature.celsius,  UnitTemperature.fahrenheit,  UnitTemperature.kelvin]
        
        let convert = Measurement( value: number, unit: unitTemperature[inputUnit])
        
  let result = convert.converted(to: unitTemperature[outputUnit])
        return result.value
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section( header: Text ("select the unit to convert")){
                    Picker( "input unit", selection: $inputUnit){
                        ForEach( 0..<graduses.count){
                            Text("\(self.graduses[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section( header: Text ("select the unit to convert to")){
                    Picker( "output unit", selection: $outputUnit){
                        ForEach( 0..<graduses.count){
                            Text("\(self.graduses[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section{
                    TextField("Number of graduses to converted", text: $numberOfGraduses)
                        .keyboardType(.decimalPad)
                }
                
                Section( header: Text ("The result of converted")){
                    Text("\(converter, specifier: "%.2f")")
                    
                }
            }
            .navigationBarTitle( "TempConverter")
        }
            .padding()
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
