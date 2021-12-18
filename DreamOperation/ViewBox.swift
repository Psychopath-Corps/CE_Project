//
//  ViewBox.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

let w = UIScreen.main.bounds.width
let h = UIScreen.main.bounds.height

struct box: View {
    let posi: (x:CGFloat, y: CGFloat)
    let n: Int
    var body: some View {
        ZStack{
            Text("\(n)")
                .frame(width: w/10, height: w/10)
                .background(Color.gray)
                .border(Color.green)
                .position(x: posi.x, y: posi.y)
        }
    }
}

struct dice: View {
    @ObservedObject var game: GameManager = .game
    @State var walk = false
    var body: some View {
        ZStack{
            if game.isPosi {
                if game.heartMove {
                    ForEach(1..<game.health+1){ i in
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .position(x: game.images[i].x, y: game.images[i].y)
                    }
                }
                
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .position(x: game.images[0].x, y: game.images[0].y)
                if !game.heartMove {
                    Text("\(game.num)")
                        .font(.largeTitle)
                        .position(x: game.images[0].x, y: game.images[0].y)
                    if !walk {
                        Button("止める"){
                            walk = true
                            game.stop()
                        }.font(.largeTitle)
                            .border(Color.black)
                            .position(x: game.images[0].x, y: game.images[0].y + 100)
                    } else if walk {
                        Button("決定"){
                            walk = false
                            game.clearView = 0.0
                            game.diceroll = false
                        }.font(.largeTitle)
                            .border(Color.black)
                            .position(x: game.images[0].x, y: game.images[0].y + 100)
                    }
                }
            }
        }
    }
}
