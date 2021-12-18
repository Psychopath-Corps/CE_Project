//
//  PlayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var data = GameManager()
    // TODO: ここでプレイ画面に移動した時の初期値を調節
    @GestureState private var dragOffset = CGSize(width: 55, height: -655)
    @GestureState private var drag = CGSize.zero
    @State private var position = CGSize.zero
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack{
            Group{
                Image("green")
                    .resizable()
                    .frame(width: w*3, height: w*1.5)
                    .position(x: w, y: w/2)
                if data.isPosi{
                    ForEach(0..<66){ num in
                        box(posi: data.stepPosi[num], n: num)
                    }
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: data.stepPosi[data.pinposi.a].x, y: data.stepPosi[data.pinposi.a].y-w/40)
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: data.stepPosi[data.pinposi.b].x, y: data.stepPosi[data.pinposi.b].y-w/40)
                }
                
            }.offset(x: position.width + dragOffset.width + drag.width, y: position.height + dragOffset.height + drag.height)
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
                        Button("←"){if data.pinposi.a>=1{data.pinposi.a-=1}}
                        Button("1"){}
                        Button("→"){data.pinposi.a+=1}
                    }
                }
                
                VStack{
                    HStack{
                        Button("←"){if data.pinposi.b>=1{data.pinposi.b-=1}}
                        Button("2"){}
                        Button("→"){data.pinposi.b+=1}
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
                    Text("ピン1: \(data.pinposi.a) ")
                    Text("ピン2: \(data.pinposi.b)")
                    Spacer()
                }
                Spacer()
            }
        }.onAppear{
            data.mapPosi = (x: w/2, y: -h)
            createPosi()
        }
    }
    
    func spot(num: Int) {
        
    }
    
    func createPosi() {
        // 0~20
        for i in 0...20{
            let new = (x: w/10 * CGFloat(i), y: w)
            data.stepPosi.append(new)
        }
        // 21~30
        for i in 1...10{
            let new = (x: w * 2, y: w - w/10 * CGFloat(i))
            data.stepPosi.append(new)
        }
        //31~50
        for i in 1...20{
            let new = (x: w*2 - w/10 * CGFloat(i), y: CGFloat(0))
            data.stepPosi.append(new)
        }
        // 51~55
        for i in 1...5{
            let new = (x: CGFloat(0), y: w/10 * CGFloat(i))
            data.stepPosi.append(new)
        }
        // 56~65
        for i in 1...10{
            let new = (x: w/10 * CGFloat(i), y: w/2)
            data.stepPosi.append(new)
        }
        //mapPosi = (x: w/2, y: -h)
        data.isPosi = true
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
