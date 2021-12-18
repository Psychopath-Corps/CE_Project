//
//  GameManager.swift.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/17.
//

import SwiftUI

class GameManager: ObservableObject {
    private init(){ }
    
    static let game = GameManager()
    
    @Published var pins:[(num: Int, name: String, color: String, style: String,
                          place: Int, money: Int, health: Int,
                          salary: Int, pay: Int, follow1: String, follow2: String)] = []
    
    @Published var stepPosi: [(x:CGFloat, y: CGFloat)] = []
    
    @Published var mapPosi = (x: CGFloat(55), y: CGFloat(-655))
    // stepの座標に合わせる
    @Published var pin1 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pin2 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pinposi = (a: 0,b: 0,c: 0,d: 0)
    @Published var playing = 1
    @Published var gamen = "setting"
    @Published var diceroll = false
    
    let health = 9
    @Published var timerHandler : Timer?
    @Published var images:[(x:CGFloat, y:CGFloat)] = []
    @Published var isPosi = false
    @Published var heartMove = true
    @Published var num = 1
    @Published var slot = false
    @Published var clearView = 0.0
    /// サイコロロジック
    func saicoro(max: Int) -> Int {
        let saicoro = Int.random(in: 1...max)
        return saicoro
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
            if !self.heartMove {
                self.num = Int.random(in: 1...9)
            } else {
                self.animation()
            }
        }
    }
    
}
