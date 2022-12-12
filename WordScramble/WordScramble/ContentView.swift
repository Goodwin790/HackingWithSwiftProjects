//
//  ContentView.swift
//  WordScramble
//
//  Created by Сергей Киров on 03.08.2021.
//

import SwiftUI

struct DrawText: ViewModifier {
    let font = Font.system( size: 22, weight: .heavy, design: .default)
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

struct DrawHorizontalText: View{
    var text: String
    var textResult: String
    
    var body: some View{
        HStack{
            Text(text)
                .modifier(DrawText())
                .foregroundColor(Color.black)
            
            Text(textResult)
                .modifier(DrawText())
                .foregroundColor(Color.black)
        }
    }
}

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var allWords = [String]()
    
    @State private var totalScore = 0
    
    var body: some View {
        NavigationView{
            
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                List( usedWords, id: \.self){ word in
                    HStack{
                    Image(systemName: "\(word.count).circle")
                    Text(word)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(word)
                    .accessibilityHint("\(word.count) letters")   
                }
                
                HStack{
                    Text("score is")
                    Text("\(totalScore)")
                }
                DrawHorizontalText(text: "Score: ", textResult: "\(totalScore)")
            }
            
            
            
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .navigationBarItems(leading:
                                    Button(action: startGame){
                                        Text("Start game")
                                    },trailing:
                                        Button(action: setNewWord){
                                            Text("New word")
                                        })
            
            
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("ok")))
            }
        }
    }
    func setNewWord(){
        rootWord = allWords.randomElement() ?? "silkworm"
    }
    func addNewWord(){
        //lowercase and trim new word,to make sure we don't add dublicatewords with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //Exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "word used already", message: "be more original")
            return
        }
        guard isPossible (word: answer) else {
            wordError (title: "word not recognized", message: "you can't just make them up, you know!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "word not possible", message: "that isn't a real Word!")
            return
        }
        guard answer.count >= 3 else {
            wordError(title: "Word not possible", message: "This is less than 3 characters!")
            return
        }
        guard answer != rootWord else{
            wordError(title: "Word not possible", message: "You can't use rootword!")
            return
        }
        //extra validation to come
        usedWords.insert(answer, at: 0)
        totalScore += answer.count
        newWord = ""
    }
    func startGame () {
        //find the url for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            //load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL){
                //split the string up into an array of strings, splitting on line breaks
                allWords = startWords.components(separatedBy: "\n")
                
                //pick the one random word, or use "silkworm as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                totalScore = 0
                //if we are here everything has worked, so we can exit
                return
                
            }
        }
        // if we are *here* then there was a problem - trigger a crash and report the error
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal (word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal (word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        
        return misspelledRange.location == NSNotFound
    }
    func wordError (title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

