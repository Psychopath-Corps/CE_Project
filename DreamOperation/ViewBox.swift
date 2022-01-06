//
//  ViewBox.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct pinSkin: View {
    @ObservedObject var game: GameManager = .game
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    var num: Int
    var size: CGFloat
    var body: some View {
        VStack(spacing: 0){
            Image("頭\(game.pins[num].color)")
                .resizable()
                .frame(width: h*0.4*size, height: h*0.2*size)
            Image("\(game.pins[num].style)")
                .resizable()
                .frame(width: h*0.4*size, height: h*0.4*size)
            //Image("足\(game.pins[num].color)")
            Image("足黒")
                .resizable()
                .frame(width: h*0.4*size, height: h*0.2*size)
        }
    }
}

// マップに番号を振る
struct box: View {
    @ObservedObject var game: GameManager = .game
    let n: Int
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let posi: (x:CGFloat, y: CGFloat)
    var body: some View {
        ZStack{
            if n == 0 || n == 20 || n == 36 ||
                n == 56 || n == 62 || n == 72 {
                Image("ます")
                    .resizable()
                    .frame(width: w/5, height: w/5 * 0.625)
                    .border(Color.gray)
                    .position(x: posi.x, y: posi.y)
            } else {
                Image("ます")
                    .resizable()
                    .frame(width: w/10, height: w/10 * 0.625)
//                    .background(Color.gray)
//                    .border(Color.green)
                    .position(x: posi.x, y: posi.y)
            }
            
        }
        Text("\(n)")
            .foregroundColor(Color.black)
            .fontWeight(.heavy)
            .position(x: posi.x, y: posi.y)
    }
}

// サイコロを振る画面
struct dice: View {
    @ObservedObject var game: GameManager = .game
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    /// タイマー
    @State var timer: Timer!
    var timerCount = 0.0
    
    @State var images:[(x:CGFloat, y:CGFloat)] = []
    @State var isPosi = false
    
    /// サイコロのアニメーションの起動の有無
    @State var heartMove = true
    @State var num = 1
    @State var slot = false
    var body: some View {
        ZStack{
            
            
            // ハート(位置が決まり次第描画)
            if isPosi {
                // でかいハート
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .position(x: images[0].x, y: images[0].y)
                
                if heartMove {
                    ForEach(1..<game.pins[game.playing].health+1){ i in
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.pink)
                            .position(x: images[i].x, y: images[i].y)
                    }
                }
                   
                // ハートが集まるアニメーションが終わったら
                if !heartMove {
                    // スロットの数字
                    Text("\(num)")
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.red)
                        .position(x: images[0].x, y: images[0].y)
                    // ルーレットが回ってる時
                    if !game.walk {
                        Button("止める"){
                            game.walk = true
                            // ルーレットを止める
                            stop()
                        }.font(.largeTitle)
                            .border(Color.black)
                            .position(x: images[0].x, y: images[0].y + 100)
                        // 止めるボタンを押した時
                    } else if game.walk {
                        Button("決定"){
                            game.walk = false
                            game.appear = true
                            //  半透明から透明にする
                            game.clearView = 0.0
                            // このビューを非表示にする
                            game.diceroll = false
                            // アニメーションのBoolを元に戻す
                            heartMove = true
                            // 出た目分進める
                            game.step(dices: num)
                        }.font(.largeTitle)
                            .border(Color.black)
                            .position(x: images[0].x, y: images[0].y + 100)
                    }
                }
            }
        }
        .onAppear(){
            createPosi(health: game.pins[game.playing].health)
            // ルーレットをスタート
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
    /// サイコロのアニメーション
    func animation() {
        for i in 1...game.pins[game.playing].health {
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
        num = Int.random(in: 1...game.pins[game.playing].health)
    }
    
    /// ルーレットを開始する
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            if !heartMove {
                num = Int.random(in: 1...game.pins[game.playing].health)
            } else {
                animation()
            }
        }
    }
}

// イベント画面
struct event: View {
    @ObservedObject var game: GameManager = .game
    @State var isMovingTurn = false
    var body: some View {
        ZStack {
            VStack{
                Text("お金が〇〇円になりました")
                Button("OK") {
                    isMovingTurn = true
                    game.two = true
                }
                // ターン画面に画面遷移
                .fullScreenCover(isPresented: $isMovingTurn){
                    TurnView(isMoving: $isMovingTurn)
                }
            }
            .frame(width: game.w*0.7, height: game.h*0.6)
        }
    }
}
