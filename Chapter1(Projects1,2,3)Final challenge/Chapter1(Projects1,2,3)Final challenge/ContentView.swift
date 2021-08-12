//
//  ContentView.swift
//  Chapter1(Projects1,2,3)Final challenge
//
//  Created by Сергей Киров on 10.07.2021.
//

import SwiftUI

struct ContentView: View {
    struct ButtonStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .clipShape( Capsule())
                .overlay( Capsule( )
                            .stroke(Color.black, lineWidth: 3))
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
    
    @State private var picks = [ "Rock", "Paper", "Scissors"]
    
    @State private var choiseOfApp = Int.random(in:0...2)
    @State private var playerMustWin = Bool.random()
    @State private var guessCounter = 0
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTittle = ""
    @State private var score = 0
 
    var playerWay: String{
        let playerFortune: String
        if playerMustWin{
            playerFortune = "Win"
        }
        else{
            playerFortune = "Lose"
        }
        return playerFortune
    }
 
    
    var body: some View {
        ZStack{
            LinearGradient( gradient: Gradient(colors: [ .white, .gray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack( spacing: 30){
                VStack{
                    Text( "The app choosen ")
                        .font( .largeTitle)
                        Text( "\(picks[choiseOfApp])")
                            .font( .largeTitle)
                   Text( "Player must \( playerWay)")
                    .font( .largeTitle)

                    }
                Spacer()
                
                VStack( spacing: 50){
                    Text( "Tap to your choose")
                    ForEach(0..<3){number in
                        Button(action:{
                            self.answerTapped(number)
                        }) {
                            Text( picks[ number])
                                .font(.largeTitle)
                                .foregroundColor( .black)
                                .modifier(ButtonStyle())
                                
                        }
                    }
                    Spacer()
                }
                }
 
            
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTittle), message: Text("Your score is \(score )"), dismissButton: .default(Text("Continue")) {
                    self.playerAnswer()
                })
            }

        }
    }
    func correctAnsvers() -> Int{
        var correctAnswer: Int
        if choiseOfApp == 0{
            correctAnswer = 1
        }else if choiseOfApp == 1{
            correctAnswer = 2
        }
        else{
            correctAnswer = 0
        }
        return correctAnswer
    }
    
    func answerTapped(_ answer: Int){
        guessCounter += 1
        if answer == choiseOfApp{
            scoreTittle = "Draw"
        }else if answer == correctAnsvers() && playerMustWin {
            scoreTittle = "Correct"
            score += 1
        }else if answer != correctAnsvers() && !playerMustWin{
            scoreTittle = "Correct"
            score += 1
        }
        else{
            scoreTittle = "Wrong"
            score -= 1
        }
      

        if guessCounter == 10{
           scoreTittle = "Game over!"
            guessCounter = 0
        }
        
        if score <= 0 {
            score = 0
        }
        showingScore = true
    }
    
    func playerAnswer(){
        choiseOfApp = Int.random(in: 0..<3)
        playerMustWin = Bool.random()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
