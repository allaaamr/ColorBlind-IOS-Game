//
//  ContentView.swift
//  ColorBlind
//
//  Created by Alaa Amr Abdelazeem on 29/08/2022.
//

import SwiftUI



struct ContentView: View {
    @State private var GameTitle = "OrangeBlind"
    @State private var gameEnded = false
    @State private var shade = Int.random(in: 0..<15)
    @State private var shades =
        ["#ffb300","#ffa812","#ffa700","#ff9f00",
         "#ff8f00","#ff8c00","#ff7f00","#f77f00",
         "#ff7518", "#ffbf00", "#ffba00", "#f28500",
         "#fb9902", "#ffa813", "#ffa811", "#ff9944"
    ]
    private var ranges = [(0..<4),(4..<8),(8..<12),(12..<16)]
    @State private var attempts = 4
    
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack {
                Text(GameTitle)
                    .foregroundColor(.orange)
                    .font(.system(size: 30))
                    .alert(GameTitle, isPresented: $gameEnded) {
                        Button("Reset", role: .destructive, action: resetGame)
                    }
                Spacer()
                Text("Can you get the color?")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                ColorBox(shade: shades[shade])
                Text("Remaining Attempts: \(attempts)")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Spacer()
                ForEach(ranges, id: \.self) { range in
                    HStack {
                        ForEach(range, id: \.self) { i in
                            ColorBox(shade: shades[i])
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("Tap: \(i)")
                                            playerTap(index: i)
                                        }
                                )
                        }
                    }
                }
                Spacer()
                Button("Reset") {
                    resetGame()
                }
            }
            
        }
    }
    
   
    
    func resetGame() {
        GameTitle = "OrangeBlind"
        attempts = 4
        shades = ["#fe5a1d","#ed872d","#ff7518","#fd5800",
         "#ff7e00","#ff9933","#ff7f00","#ff8c00",
         "#ff8f00", "#ffbf00", "#ffba00", "#f28500",
                  "#cd5700", "#ec5800", "#e86100", "#f77f00"].shuffled()
    }
    func playerTap(index: Int){
        if shades[index] != "#000000"{
            if index != shade {
                if attempts > 1 {
                    attempts -= 1
                    shades[index] = "#000000"
                    
                }
                else{
                    gameEnded = true
                    GameTitle = "You Lost"
                }
            }
            else {
                gameEnded = true
                GameTitle = "You Won"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
