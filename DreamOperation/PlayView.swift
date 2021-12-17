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
    @State var mapPosi = (x: CGFloat(0), y: CGFloat(0))
    // stepの座標に合わせる
    @State var pin1 = (x: CGFloat(0), y: CGFloat(0))
    @State var pin2 = (x: CGFloat(0), y: CGFloat(0))
    
    @State var moving = (x: CGFloat(0), y: CGFloat(0))
    var body: some View {
        ZStack{
            Group{
                Image("mapImage")
                    .resizable()
                    .frame(width: w*2, height: w)
                    .border(Color.black)
                    
                mapView()
                    
                Image("pinImage")
                    .resizable()
                    .frame(width: 40, height: 80)
                    .position(x: pin1.x,
                              y: pin1.y)
                Image("pinImage")
                    .resizable()
                    .frame(width: 40, height: 80)
                    .position(x: pin2.x,
                              y: pin2.y)
            }.position(x: moving.x,
                       y: moving.y)
            HStack{
            VStack{
                Button("↑"){moving.y+=50}
                HStack{
                    Button("←"){moving.x+=50}
                    Button("○"){moving=(x: 0, y: 0)}
                    Button("→"){moving.x-=50}
                }
                Button("↓"){moving.y-=50}
            }
            
            VStack{
                Button("↑"){pin1.y-=50}
                HStack{
                    Button("←"){pin1.x-=50}
                    Button("1"){}
                    Button("→"){pin1.x+=50}
                }
                Button("↓"){pin1.y+=50}
            }
            
            VStack{
                Button("↑"){pin2.y-=50}
                HStack{
                    Button("←"){pin2.x-=50}
                    Button("2"){}
                    Button("→"){pin2.x+=50}
                }
                Button("↓"){pin2.y+=50}
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
                    VStack{
                        Text("View座標")
                        Text("x:\(moving.x)")
                        Text("y:\(moving.y)")
                    }
                    Spacer()
                }
                Spacer()
            }
        }.onAppear{
            moving = (x: w, y: -w/10)
            pin1 = (x: -200, y: 500)
            pin2 = (x: -250, y: 500)
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
