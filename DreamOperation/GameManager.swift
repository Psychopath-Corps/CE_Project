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
    /// 設定画面の遷移
    @State var isMovingSetting = false
    
    /// 今あるポジションを保存
    @Published var position = CGSize.zero
    /// ターン画面に遷移
    @Published var isMovingTurn = false
    
    /// 横の画面サイズを取得
    let w = UIScreen.main.bounds.width
    /// 縦の画面サイズを取得
    let h = UIScreen.main.bounds.height
    
    /// 初期位置を決める
    @GestureState var dragOffset = CGSize(width: 375, height: -660)
    /// プレイヤーのステータス
    @Published var pins:[(num: Int, name: String, color: String, style: String,
                          place: Int, money: Int, health: Int,
                          salary: Int, pay: Int, follow1: String, follow2: String)] = []
    
    
    @Published var stepPosi: [(x:CGFloat, y: CGFloat)] = []
    
    @Published var mapPosi = (x: CGFloat(55), y: CGFloat(-655))
    /// stepの座標に合わせる
    @Published var pin1 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pin2 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pinposi = (a: 0,b: 0,c: 0,d: 0)
    @Published var playing = 1
    
    /// 画面を切り替えるための
    @Published var gamen = "setting"
    /// サイコロを振る画面の表示の有無
    @Published var diceroll = false
    
    /// プレイヤーのライフ
    let health = 9
    
    /// タイマー
    @Published var timer: Timer!
    @Published var timerCount = 0.0
    
    @Published var images:[(x:CGFloat, y:CGFloat)] = []
    @Published var isPosi = false
    
    /// サイコロのアニメーションの起動の有無
    @Published var heartMove = true
    @Published var num = 1
    @Published var slot = false
    
    /// 背景を半透明する具合
    @Published var clearView = 0.0
    
    /// イベント画面の表示の有無
    @Published var eventGamen = false
    
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
    
    /// サイコロのアニメーション
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
    
    /// 決定ボタンを押した時の処理
    func stop() {
        timer?.invalidate()
        num = Int.random(in: 1...9)
    }
    
    /// ルーレットを開始する
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            if !self.heartMove {
                self.num = Int.random(in: 1...9)
            } else {
                self.animation()
            }
        }
    }
    
    /// 画像の座標を取得し、ターン開始の時にその座標へ移動させる処理
    func pinXY(dragX: CGSize, dragY: CGSize) {
        
    }
    
    /// マスを進める処理
    func step(dice: Int) {
        self.timer?.invalidate()
        self.timerCount = Double(dice)
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true){ _ in
            self.timerCount -= 1
            print(self.timerCount)
            self.pinposi.a += 1
            if self.timerCount == 0 {
                self.timer?.invalidate()
                self.timer = nil
                self.eventGamen = true
                self.clearView = 0.5
            }
        }
    }
    
    func spot(num: Int) {

    }
    
    /// マスを生成
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
