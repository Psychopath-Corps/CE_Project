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
    let health = 9
    @State var timerHandler : Timer?
    @State var images:[(x:CGFloat, y:CGFloat)] = []
    @State var isPosi = false
    @State var heartMove = true
    @State var num = 1
    @State var slot = false
    var body: some View {
        ZStack{
            if isPosi {
                if heartMove {
                    ForEach(1..<health+1){ i in
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .position(x: images[i].x, y: images[i].y)
                    }
                }
                
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .position(x: images[0].x, y: images[0].y)
                if !heartMove {
                    Text("\(num)")
                        .font(.largeTitle)
                        .position(x: images[0].x, y: images[0].y)
                    Button("決定"){
                        stop()
                    }.font(.largeTitle)
                        .border(Color.black)
                        .position(x: images[0].x, y: images[0].y + 100)
                }
            }
        }.onAppear(){
            createPosi(health: health)
            start()
        }
    }
    // ハートの座標の生成
    func createPosi(health: Int) {
        images.append((x: w, y: h))
        images[0] = (x: w*0.6, y: h/2) // スロット
        for i in 1...health {
            images.append((x: w, y: h))
            switch i {
            case 1: images[i] = (x: w*0.6, y: h/4)
            case 2: images[i] = (x: w*0.6 - 30, y: h/4)
            case 3: images[i] = (x: w*0.6 + 30, y: h/4)
            case 4: images[i] = (x: w*0.6 - 60, y: h/4)
            case 5: images[i] = (x: w*0.6 + 60, y: h/4)
            case 6: images[i] = (x: w*0.6 - 90, y: h/4)
            case 7: images[i] = (x: w*0.6 + 90, y: h/4)
            case 8: images[i] = (x: w*0.6 - 120, y: h/4)
            case 9: images[i] = (x: w*0.6 + 120, y: h/4)
            default: return
            }
        }
        isPosi = true
    }
    func animation() {
        for i in 1...health {
            if images[i].y <= h/2 {
                images[i].y += 1
            } else {
                heartMove = false
            }
            if w*0.6 - images[i].x <= 0 {
                images[i].x -= 1.5
            } else {
                images[i].x += 1.5
            }
        }
    }
    func stop() {
        timerHandler?.invalidate()
        num = Int.random(in: 1...9)
    }
    func start() {
        timerHandler = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            if !heartMove {
                num = Int.random(in: 1...9)
            } else {
                animation()
            }
        }
    }
}
