//
//  PlayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var game: GameManager = .game
    // TODO: ここでプレイ画面に移動した時の初期値を調節
    @GestureState private var dragOffset = CGSize(width: 375, height: -660)
    @GestureState private var drag = CGSize.zero
    @State private var position = CGSize.zero
    @State var isMoving = false
   
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack{
            Group{
                Image("green")
                    .resizable()
                    .frame(width: w*3, height: w*1.5)
                    .position(x: w, y: w/2)
                if game.isPosi{
                    ForEach(0..<66){ num in
                        box(posi: game.stepPosi[num], n: num)
                    }
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: game.stepPosi[game.pinposi.a].x, y: game.stepPosi[game.pinposi.a].y-w/40)
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: game.stepPosi[game.pinposi.b].x, y: game.stepPosi[game.pinposi.b].y-w/40)
                }
            }
            .offset(x: position.width + dragOffset.width + drag.width, y: position.height + dragOffset.height + drag.height)
            
            // このモディファイアの置く位置によってどのビューに反応して動くか決める
            .gesture(
                DragGesture()
                    .updating($drag, body: { (value, state, transaction) in
                        
                        state = value.translation
                        
                        
                    })
                    .onEnded({ (value) in
                        self.position.height += value.translation.height
                        self.position.width += value.translation.width
                    })
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
                        Text("x:\(position.width + dragOffset.width) ")
                        Text("y:\(position.height + dragOffset.height) ")
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
                    Button("歩む"){
                        game.diceroll = true
                        game.clearView = 0.5
                        game.createPosi(health: game.health)
                        game.start()
                        
                    }
                }
            }
        }.onAppear{
            game.mapPosi = (x: w/2, y: -h)
            createPosi()
        }        
    }
    
    func spot(num: Int) {
        
    }
    
    func createPosi() {
        // 0~20
        for i in 0...20{
            let new = (x: w/10 * CGFloat(i), y: w)
            game.stepPosi.append(new)
        }
        // 21~30
        for i in 1...10{
            let new = (x: w * 2, y: w - w/10 * CGFloat(i))
            game.stepPosi.append(new)
        }
        //31~50
        for i in 1...20{
            let new = (x: w*2 - w/10 * CGFloat(i), y: CGFloat(0))
            game.stepPosi.append(new)
        }
        // 51~55
        for i in 1...5{
            let new = (x: CGFloat(0), y: w/10 * CGFloat(i))
            game.stepPosi.append(new)
        }
        // 56~65
        for i in 1...10{
            let new = (x: w/10 * CGFloat(i), y: w/2)
            game.stepPosi.append(new)
        }
        //mapPosi = (x: w/2, y: -h)
        game.isPosi = true
    }
}

