//
//  ContentView.swift
//  ChallengeOfPart2
//
//  Created by Сергей Киров on 19.08.2021.
//

import SwiftUI

struct ContentView: View {
    
let multiplicand = [1,2,3,4,5,6,7,8,9,10,11,12]
let factor = [1,2,3,4,5,6,7,8,9,10]
    @State private var userGuess = ""
    
    var body: some View {
        ZStack{
            AngularGradient(gradient: Gradient(colors: [.blue, .green, .yellow, .orange, .pink]), center: .center)
            VStack(spacing: 30){
                HStack{
                    ForEach(0..<multiplicand.count){ number in
                        Button("\(multiplicand[number])"){
                            
                        }
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
}
func startGame(){
    
}


func multiplied (multicand: Int, factor: Int) {
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
