//
//  ContentView.swift
//  HackingWithSwiftOroject1Introduction
//
//  Created by Сергей Киров on 05.06.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        Button( "show alert"){
            self.$showingAlert = true
        }
        .alert( isPresented: $showingAlert){
            Alert( title: Text( "Hello swiftUI"), message: Text( "This is some detail message"), dismissButton: .default( Text( "ok")))
        
        }
//        LinearGradient( gradient:Gradient(colors: [.white, .black, .blue, .pink]),startPoint: .top, endPoint: .bottom)
//
//        RadialGradient( gradient: Gradient(colors: [.blue, .black, .clear]), center: .bottom, startRadius: 20, endRadius: 500)
        
//        AngularGradient( gradient: Gradient(colors: [ .red,.yellow,.green,.blue,.purple,.red]), center: .center)
//            .padding()
//        Button( "Tap me!") {
//            print("Button was tapped")
//        }
//        Button( action: {
//            print( "Button was tapped")
//        }){
//            Text( "Tap me!")
//        }
//        Button( action:{
//            print( "Edit button was tapped")
//        }){
//            Image( systemName: "pencil")
//        }
//
//        Button(action: {
//            print("Edit button was tapped")
//        }) {
//            HStack(spacing: 10) {
//                Image(systemName: "pencil")
//                Text("Edit")
//            }
//        }
        
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
