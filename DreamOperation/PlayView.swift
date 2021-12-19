//
//  PlayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var game: GameManager = .game
    // マップを移動
    @GestureState var drag = CGSize.zero
    /// 横の画面サイズを取得
    let w = UIScreen.main.bounds.width
    /// 縦の画面サイズを取得
    let h = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            Group{
                Image("green")
                    .resizable()
                    .frame(width: w*3, height: w*1.5)
                    .position(x: w, y: w/2)
                // マス目を生成
                if game.isPosi{
                    ForEach(0..<66){ num in
                        box(n: num, posi: game.stepPosi[num])
                    }
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: game.stepPosi[game.pinposi[0]].x, y: game.stepPosi[game.pinposi[0]].y-w/40)
                        .opacity(game.pinClear[0])
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: game.stepPosi[game.pinposi[1]].x, y: game.stepPosi[game.pinposi[1]].y-w/40)
                        .opacity(game.pinClear[1])
                }
            }
            .offset(x: game.position.width + game.dragOffset.width + drag.width, y: game.position.height + game.dragOffset.height + drag.height)
            // マップを移動できるようにするロジック
            .gesture(
                DragGesture()
                    .updating($drag, body: { (value, state, transaction) in
                        
                        state = value.translation
                        
                        
                    })
                    .onEnded{ value in
                        game.position.height += value.translation.height
                        game.position.width += value.translation.width
                    }
            )
            HStack{
                VStack{
                    HStack{
                        Button("←"){if game.pinposi[0]>=1{game.pinposi[0]-=1}}
                        Button("1"){}
                        Button("→"){game.pinposi[0]+=1}
                    }
                }
                
                VStack{
                    HStack{
                        Button("←"){if game.pinposi[1]>=1{game.pinposi[1]-=1}}
                        Button("2"){}
                        Button("→"){game.pinposi[1]+=1}
                    }
                }
            }// HS
            
            
            VStack{
                // DebugView
                HStack{
                    VStack{
                        Text("マップ")
                        Text("x:\(game.position.width + game.dragOffset.width + drag.width) ")
                        Text("y:\(game.position.height + game.dragOffset.height + drag.height) ")
                    }
                    Text("ピン1: \(game.pinposi[0])")
                    Text("ピン2: \(game.pinposi[1])")
                    Spacer()
                }
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                HStack {
                    // サイコロを振ったあともう一度ボタンを押させないため
                    if !game.appear {
                        // サイコロを振る画面に移動
                        Button("歩む"){
                            game.diceroll = true
                            // 背景を半透明にする
                            game.clearView = 0.5
                            game.createPosi(health: game.health)
                            // ルーレットをスタート
                            game.start()
                        }
                    } else if game.walk {
                        
                    }
                }
            }
        }.onAppear{
            game.mapPosi = (x: w/2, y: -h)
            game.createPosi()
        }
    }
    
    
}

