//
//  PlayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var data = GameManager()
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
   
    var body: some View {
        ZStack{
            Group{
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

            }.position(x: data.mapPosi.x, y: data.mapPosi.y)
            
            HStack{
                VStack{
                    Button("↑"){data.mapPosi.y+=50}
                    HStack{
                        Button("←"){data.mapPosi.x+=50}
                        Button("○"){data.mapPosi=(x: w/2, y: h/2)}
                        Button("→"){data.mapPosi.x-=50}
                    }
                    Button("↓"){data.mapPosi.y-=50}
                }
            
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
                        Text("x:\(data.mapPosi.x) ")
                        Text("y:\(data.mapPosi.y) ")
                    }
                    VStack{
                        Text("ピン１")
                        Text("x:\(data.pin1.x) ")
                        Text("y:\(data.pin1.y) ")
                    }
                    VStack{
                        Text("ピン２")
                        Text("x:\(data.pin2.x) ")
                        Text("y:\(data.pin2.y) ")
                    }
                    Spacer()
                }
                Spacer()
            }
        }.onAppear{
            data.mapPosi = (x: w/2, y: -h)
            createPosi()
        }
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
