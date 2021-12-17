//
//  PlayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var data: Observer = .data
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    @State var stepPosi: [(x:CGFloat, y: CGFloat)] = []
    @State var isPosi = false
    
    @State var mapPosi = (x: CGFloat(0), y: CGFloat(0))
    // stepの座標に合わせる
    @State var pin1 = (x: CGFloat(0), y: CGFloat(0))
    @State var pin2 = (x: CGFloat(0), y: CGFloat(0))
    @State var pinposi = (a: 0,b: 0,c: 0,d: 0)
    var body: some View {
        ZStack{
            Group{
                if isPosi{
                    ForEach(0..<66){ num in
                        box(posi: stepPosi[num], n: num)
                    }
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: stepPosi[pinposi.a].x, y: stepPosi[pinposi.a].y-w/40)
                    Image("pinImage")
                        .resizable()
                        .frame(width: 40, height: 80)
                        .position(x: stepPosi[pinposi.b].x, y: stepPosi[pinposi.b].y-w/40)
                }
            }.position(x: mapPosi.x, y: mapPosi.y)
            HStack{
                VStack{
                    Button("↑"){mapPosi.y+=50}
                    HStack{
                        Button("←"){mapPosi.x+=50}
                        Button("○"){mapPosi=(x: w/2, y: h/2)}
                        Button("→"){mapPosi.x-=50}
                    }
                    Button("↓"){mapPosi.y-=50}
                }
            
            VStack{
                HStack{
                    Button("←"){if pinposi.a>=1{pinposi.a-=1}}
                    Button("1"){}
                    Button("→"){pinposi.a+=1}
                }
            }
            
            VStack{
                HStack{
                    Button("←"){if pinposi.b>=1{pinposi.b-=1}}
                    Button("2"){}
                    Button("→"){pinposi.b+=1}
                }
            }
            }// HS
            
            
            VStack{
                // DebugView
                HStack{
                    VStack{
                        Text("マップ")
                        Text("x:\(mapPosi.x) ")
                        Text("y:\(mapPosi.y) ")
                    }
                    VStack{
                        Text("ピン１")
                        Text("x:\(pin1.x) ")
                        Text("y:\(pin1.y) ")
                    }
                    VStack{
                        Text("ピン２")
                        Text("x:\(pin2.x) ")
                        Text("y:\(pin2.y) ")
                    }
                    Spacer()
                }
                Spacer()
            }
        }.onAppear{
            mapPosi = (x: w/2, y: -h)
            createPosi()
        }
    }
    func createPosi() {
        // 0~20
        for i in 0...20{
            let new = (x: w/10 * CGFloat(i), y: w)
            stepPosi.append(new)
        }
        // 21~30
        for i in 1...10{
            let new = (x: w * 2, y: w - w/10 * CGFloat(i))
            stepPosi.append(new)
        }
        //31~50
        for i in 1...20{
            let new = (x: w*2 - w/10 * CGFloat(i), y: CGFloat(0))
            stepPosi.append(new)
        }
        // 51~55
        for i in 1...5{
            let new = (x: CGFloat(0), y: w/10 * CGFloat(i))
            stepPosi.append(new)
        }
        // 56~65
        for i in 1...10{
            let new = (x: w/10 * CGFloat(i), y: w/2)
            stepPosi.append(new)
        }
        //mapPosi = (x: w/2, y: -h)
        isPosi = true
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
