//
//  ContentView.swift
//  Project2GuessTheFlag
//
//  Created by Сергей Киров on 08.06.2021.
//

import SwiftUI

struct ContentView: View {
    struct FlagImage: ViewModifier{
        func body( content: Content)-> some View{
            content
//                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
            
        }
    }


    
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private  var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    
    @State private var wrongAnswerAmount = 0.0
    
    @State private var wrongAnswer = 0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack( spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
               
                        self.flagTapped(number)
                        self.opacityAmount = 0.25
                    }) {
                        Image(self.countries[number])
                          .renderingMode(.original)
                            
                            .modifier(FlagImage())
                            .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(number == self.correctAnswer ?
                                        1 :self.opacityAmount)
                            .rotation3DEffect(.degrees(number == wrongAnswer ? wrongAnswerAmount : 0), axis: (x: 1, y: 0, z: 1)
                            )
                        
                            .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score )"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation{
                self.animationAmount += 360
            }
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            wrongAnswer = number
            withAnimation{
                self.wrongAnswerAmount += 360
            }
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        self.opacityAmount = 1
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
