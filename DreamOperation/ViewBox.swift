//
//  ViewBox.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI


// マップに番号を振る
struct box: View {
    @ObservedObject var game: GameManager = .game
    let n: Int
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let posi: (x:CGFloat, y: CGFloat)
    var body: some View {
        ZStack{
            switch n {
            case 0, 55:
                Text("\(n)")
                    .frame(width: w/5 , height: w/5)
                    .background(Color.gray)
                    .border(Color.green)
                    .position(x: posi.x - w/20, y: posi.y + w/20)
            case 20:
                Text("\(n)")
                    .frame(width: w/5, height: w/5)
                    .background(Color.gray)
                    .border(Color.green)
                    .position(x: posi.x + w/20, y: posi.y + w/20)
            case 30:
                Text("\(n)")
                    .frame(width: w/5, height: w/5)
                    .background(Color.gray)
                    .border(Color.green)
                    .position(x: posi.x + w/20, y: posi.y - w/20)
            case 50:
                Text("\(n)")
                    .frame(width: w/5, height: w/5)
                    .background(Color.gray)
                    .border(Color.green)
                    .position(x: posi.x - w/20, y: posi.y - w/20)
            case 65:
                Text("\(n)")
                    .frame(width: w/5, height: w/5)
                    .background(Color.gray)
                    .border(Color.green)
                    .position(x: posi.x - w/20, y: posi.y)
            default:
                Text("\(n)")
                    .frame(width: w/10, height: w/10)
                    .background(Color.gray)
                    .border(Color.green)
                    .position(x: posi.x, y: posi.y)
            }
        }
    }
}

// サイコロを振る画面
struct dice: View {
    @ObservedObject var game: GameManager = .game
    var body: some View {
        ZStack{
            // TODO: ここから
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
                    // TODO: ここまでのコメントを記載する
                    // ルーレットが回ってる時
                    if !game.walk {
                        Button("止める"){
                            game.walk = true
                            // ルーレットを止める
                            game.stop()
                        }.font(.largeTitle)
                            .border(Color.black)
                            .position(x: game.images[0].x, y: game.images[0].y + 100)
                        // 止めるボタンを押した時
                    } else if game.walk {
                        Button("決定"){
                            game.walk = false
                            game.appear = true
                            //  半透明から透明にする
                            game.clearView = 0.0
                            // このビューを非表示にする
                            game.diceroll = false
                            // アニメーションのBoolを元に戻す
                            game.heartMove = true
                            // 出た目分進める
                            game.step(dices: game.num)
                        }.font(.largeTitle)
                            .border(Color.black)
                            .position(x: game.images[0].x, y: game.images[0].y + 100)
                    }
                }
            }
        }
    }
}

// イベント画面
struct event: View {
    @ObservedObject var game: GameManager = .game
    @State var isMovingTurn = false
    var body: some View {
        ZStack {
            VStack{
                Text("お金が〇〇円になりました")
                Button("OK") {
                    isMovingTurn = true
                    game.two = true
                }
                // ターン画面に画面遷移
                .fullScreenCover(isPresented: $isMovingTurn){
                    TurnView(isMoving: $isMovingTurn)
                }
            }
            .frame(width: game.w*0.7, height: game.h*0.6)
        }
    }
}
