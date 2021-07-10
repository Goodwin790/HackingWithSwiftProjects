//
//  ContentView.swift
//  ViewsAndModifiersINTODUCTION
//
//  Created by Сергей Киров on 19.06.2021.
//

import SwiftUI

struct LargeBlueText: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .font( .largeTitle)
            .foregroundColor(.blue)
            .padding()
            .background(Color.black)
            .clipShape( RoundedRectangle( cornerRadius: 11))
    }
}

extension View {
    func largeBlue( ) -> some View {
        self.modifier(LargeBlueText())
    }
}

struct ContentView: View {
    var body: some View {
        
        Text("Hello World")
            .largeBlue()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.red)
//            .edgesIgnoringSafeArea(.all)
        
//        Button("Hello World") {
//            print(type(of: self.body))
//        }
//        .frame(width: 200, height: 200)
//        .background(Color.red)
//        .padding()
//            .background(Color.red)
//            .padding()
//            .background(Color.blue)
//            .padding()
//            .background(Color.green)
//            .padding()
//            .background(Color.yellow)
//
//
//
//
//        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .bottom)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
