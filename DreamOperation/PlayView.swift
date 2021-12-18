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
    
    var body: some View {
        ZStack{
            Group{
                Image("green")
                    .resizable()
                    .frame(width: game.w*3, height: game.w*1.5)
                    .position(x: game.w, y: game.w/2)
                // マス目を生成
                if game.isPosi{
                    ForEach(0..<66){ num in
                        box(n: num, posi: game.stepPosi[num])
                    }
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: game.stepPosi[game.pinposi.a].x, y: game.stepPosi[game.pinposi.a].y-game.w/40)
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: game.stepPosi[game.pinposi.b].x, y: game.stepPosi[game.pinposi.b].y-game.w/40)
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
                        Button("←"){if game.pinposi.a>=1{game.pinposi.a-=1}}
                        Button("1"){}
                        Button("→"){game.pinposi.a+=1}
                    }
                }
                
                VStack{
                    HStack{
                        Button("←"){if game.pinposi.b>=1{game.pinposi.b-=1}}
                        Button("2"){}
                        Button("→"){game.pinposi.b+=1}
                    }
                }
            }// HS
            
            
            VStack{
                // DebugView
                HStack{
                    VStack{
                        Text("マップ")
                        Text("x:\(game.position.width + game.dragOffset.width) ")
                        Text("y:\(game.position.height + game.dragOffset.height) ")
                    }
                    Text("ピン1: \(game.pinposi.a) ")
                    Text("ピン2: \(game.pinposi.b)")
                    Spacer()
                }
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                HStack {
                    // サイコロを振る画面に移動
                    Button("歩む"){
                        game.diceroll = true
                        // 背景を半透明にする
                        game.clearView = 0.5
                        game.createPosi(health: game.health)
                        // ルーレットをスタート
                        game.start()
                        
                    }
                }
            }
        }.onAppear{
            game.mapPosi = (x: game.w/2, y: -game.h)
            game.createPosi()
        }        
    }
    
    
}

