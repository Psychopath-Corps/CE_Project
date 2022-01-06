//
//  UIView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct UIView: View {
    @ObservedObject var game: GameManager = .game
    var body: some View {
        VStack{
            HStack{
                Text("\(game.pins[game.playing].name)のターン")
                Spacer()
                ForEach(0..<game.pins.count){ num in
                    pinSkin(num: num, size: CGFloat(0.2))
                }
                
            }
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("♡ \(game.pins[game.playing].health)")
                    Text("¥ \(game.pins[game.playing].money)")
                }
            }
            Spacer().frame(height: 10)
        }
    }
}

struct UIView_Previews: PreviewProvider {
    static var previews: some View {
        UIView()
    }
}
