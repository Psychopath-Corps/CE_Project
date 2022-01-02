//
//  GameManager.swift.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/17.
//

import SwiftUI

class GameManager: ObservableObject {
    private init(){ }
    
    @Published var display = "Opening"
    @Published var settingDisp = "nameSetting"
    static let game = GameManager()
    /// 設定画面の遷移
    @State var isMovingSetting = false
    
    /// 今あるポジションを保存
    @Published var position = CGSize.zero
    /// ターン画面に遷移
    @Published var isMovingTurn = false
    @Published var two = false
    
    /// 横の画面サイズを取得
    let w = UIScreen.main.bounds.width
    /// 縦の画面サイズを取得
    let h = UIScreen.main.bounds.height
    
    /// プレイヤーのステータス
    @Published var pins:[(num: Int, name: String, color: String, style: String,
                          place: Int, money: Int, health: Int, dream: String,
                          salary: Int, pay: Int, follow1: String, follow2: String)] = []
    
    /// 初期位置を決める
    @Published var dragOffset = CGSize(width: 379.8, height: -660)
    @Published var stepPosi: [(x:CGFloat, y: CGFloat)] = []
    
    @Published var mapPosi = (x: CGFloat(0), y: CGFloat(0))
    /// stepの座標に合わせる
    @Published var pin1 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pin2 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pinposi = [0, 0, 0, 0]
    @Published var pinNumber = 0
    
    /// 現在操作しているプレイヤー
    @Published var playing = 0
    
    /// 画面を切り替えるための
    @Published var gamen = "setting"
    @Published var walk = false
    /// サイコロを振る画面の表示の有無
    @Published var diceroll = false
    
    /// プレイヤーのライフ
    let health = 9
    @Published var appear = false
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
    @Published var pinClear = [1.0, 1.0, 1.0, 1.0]
    
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
    func pinXY(a: Int) {
        //safeAreaの値を取得
        let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets.left
        if(safeAreaInsets! >= 44.0){
            // 0~20
            if pinposi[a] <= 20{
                dragOffset.width = w/2 - CGFloat(pinposi[a]) * w/10 - 44
                position.width = 0
                dragOffset.height = -w * 0.75 - 27
                position.height = 0
            }
            // 21~30
            else if pinposi[a] <= 30{
                dragOffset.width = w/2 - 2 * w - 44
                position.width = 0
                dragOffset.height = -w * 0.75 - 27 + CGFloat(pinposi[a] - 20) * w/10
                position.height = 0
            }
            //31~50
            else if pinposi[a] <= 50{
                dragOffset.width = w/2 - 2 * w - 44 + CGFloat(pinposi[a] - 30) * w/10
                position.width = 0
                dragOffset.height = -w * 0.75 - 27 + w
                position.height = 0
            }
            else if pinposi[a] <= 55{
                dragOffset.width = w/2 - 44
                position.width = 0
                dragOffset.height = -w * 0.75 - 27 + w/10 - CGFloat(pinposi[a] - 50) * w/10
                position.height = 0
            }
            else if pinposi[a] <= 65{
                dragOffset.width =  w/2 - 44 - CGFloat(pinposi[a] - 55) * w/10
                position.width = 0
                dragOffset.height = -w * 0.75 - 27 + w/10 - w/2
                position.height = 0
            }
        } else {
            // 0~20
            if pinposi[a] <= 20{
                dragOffset.width = w/2 - CGFloat(pinposi[a]) * w/10
                position.width = 0
                dragOffset.height = -w * 0.75
                position.height = 0
            }
            // 21~30
            else if pinposi[a] <= 30{
                dragOffset.width = w/2 - 2 * w
                position.width = 0
                dragOffset.height = -w * 0.75 + CGFloat(pinposi[a] - 20) * w/10
                position.height = 0
            }
            //31~50
            else if pinposi[a] <= 50{
                dragOffset.width = w/2 - 2 * w + CGFloat(pinposi[a] - 30) * w/10
                position.width = 0
                dragOffset.height = -w * 0.75 + w/10
                position.height = 0
            }
            else if pinposi[a] <= 55{
                dragOffset.width = w/2
                position.width = 0
                dragOffset.height = -w * 0.75 + w/10 - CGFloat(pinposi[a] - 50) * w/10
                position.height = 0
            }
            else if pinposi[a] <= 65{
                dragOffset.width =  w/2 - CGFloat(pinposi[a] - 55) * w/10
                position.width = 0
                dragOffset.height = -w * 0.75 + w/10 - w/2
                position.height = 0
            }
        }
    }
    /// マスを進める処理
    func step(dices: Int) {
        self.timer?.invalidate()
        self.timerCount = Double(dices)
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true){ _ in
            self.timerCount -= 1
            print(self.timerCount)
            // ゴールした場合マスを進めない
            if self.pinposi[self.pinNumber] <= 64 {
                self.pinposi[self.pinNumber] += 1
            }
            // ピンと同時にマップも移動させる
            self.pinXY(a: self.pinNumber)
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
    ///TODO: これをforeachに適応。
    func createPosi() {
        let tate = w/10 * 0.6
        let yoko = w/10
        // 0
        stepPosi.append((x: -yoko/2, y: w))
        // 1~19
        for i in 1...19{
            let new = (x: yoko*CGFloat(i), y: w)
            stepPosi.append(new)
        }
        // 20
        stepPosi.append((x: w*2 + yoko/2, y: w))
        // 21~35
        for i in 1...15{
            let new = (x: w*2 + yoko/2, y: (w - tate*CGFloat(i)) - tate/2)
            stepPosi.append(new)
        }
        // 36
        stepPosi.append((x: w*2 + yoko/2, y: -tate/2))
        //37~55
        for i in 1...19{
            let new = (x: w*2 - yoko*CGFloat(i), y: -tate/2)
            stepPosi.append(new)
        }
        // 56
        stepPosi.append((x: -yoko/2, y: -tate/2))
        // 57~62
        for i in 1...5{
            let new = (x: -yoko/2, y: tate*CGFloat(i))
            stepPosi.append(new)
        }
        //62
        stepPosi.append((x: -yoko/2, y: tate*6 + tate/2))
        // 63~71
        for i in 1...9{
            let new = (x: yoko*CGFloat(i), y: tate*6 + tate/2)
            stepPosi.append(new)
        }
        // 72
        stepPosi.append((x: yoko*10 + yoko/2, y: tate*6 + tate/2))
        //mapPosi = (x: w/2, y: -h)
        isPosi = true
    }
}
