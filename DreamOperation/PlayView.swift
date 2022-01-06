//
//  PlayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var game: GameManager = .game
    @Binding var dice: Bool
    // マップを移動
    @GestureState var drag = CGSize.zero
    /// 横の画面サイズを取得
    let w = UIScreen.main.bounds.width
    /// 縦の画面サイズを取得
    let h = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            Group{
                Image("背景")
                    .resizable()
                    .frame(width: w*3, height: w*1.5)
                    .position(x: w, y: w/2)
                // マス目を生成
                if game.isPosi{
                    ForEach(0..<73){ num in
                        box(n: num, posi: game.stepPosi[num])
                    }
                    
                    ForEach(0..<game.pins.count){ i in
                        pinSkin(num: i, size: CGFloat(0.3))
                            .position(x: game.stepPosi[game.pinposi[i]].x, y: game.stepPosi[game.pinposi[i]].y-w/20)
                            .opacity(game.pinClear[i])
                    }
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
            
            
//            VStack{
//                // DebugView
//                HStack{
//                    VStack{
//                        Text("マップ")
//                        Text("x:\(game.position.width + game.dragOffset.width + drag.width) ")
//                        Text("y:\(game.position.height + game.dragOffset.height + drag.height) ")
//                    }
//                    Text("ピン1: \(game.pinposi[0])")
//                    Text("ピン2: \(game.pinposi[1])")
//                    Spacer()
//                }
//                Spacer()
//            }
            Spacer()
            VStack {
                Spacer()
                HStack {
                    // サイコロを振ったあともう一度ボタンを押させないため
                    if !game.appear {
                        // サイコロを振る画面に移動
                        Button("歩む"){
                            dice = true
                            // 背景を半透明にする
                            game.clearView = 0.5
                        }
                    } else if game.walk {
                        
                    }
                }
            }
        }.onAppear{
            game.mapPosi = (x: w/2, y: -h)
            game.createPosi()
            getSafealea()
        }
    }
    func getSafealea() {
        //safeAreaの値を取得
        let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets.left
        if(safeAreaInsets! >= 44.0){
            game.dragOffset = CGSize(width: game.w/2 - 44, height: -game.w * 0.75 - 27)
        } else {
            game.dragOffset = CGSize(width: game.w/2, height: -game.w * 0.75)
        }
        game.pinClear[1] = 0.5
    }
    
}

