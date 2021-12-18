//
//  SettingView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var game: GameManager = .game
    // 画面遷移
    @Binding var isMovingSetting: Bool
    
    var body: some View {
        ZStack{
            // 設定画面
            if game.gamen == "setting" {
                VStack{
                    Text("設定")
                    Button("PLAY"){
                        game.isMovingTurn = true
                    }
                    // ターン画面に画面遷移
                    .fullScreenCover(isPresented: $game.isMovingTurn){
                        TurnView(isMoving: $game.isMovingTurn)
                    }
                }
            // プレイ画面
            } else if game.gamen == "play" {
                PlayView()
                UIView()
                // 歩むボタンを押したら
                if game.diceroll {
                    // diceを回す画面
                    dice()
                        .background(Color.white.opacity(game.clearView))
                }
                // サイコロで出た目分進んだあとに
                if game.eventGamen {
                    // イベント画面を表示する
                    event()
                        .background(Color.white.opacity(game.clearView))
                }
            }
        }
    }
}

struct playerNameSetView: View {
    @State var timer: Timer!
    @State var btnStr = "決定"
    @State var participant = 4
    @State var nameList = ("", "", "", "")
    @State var order = []
    @State var shuffle = false
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("参加者")
                    Button(action: {
                        if participant < 4 {participant += 1}
                    }){
                        Image(systemName: "arrowtriangle.left.fill")
                    }
                    Text("\(participant)")
                    Button(action: {
                        if participant > 2 {participant -= 1}
                    }){
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                } // HS
                
                Group{
                    HStack{
                        TextField("お名前", text: $nameList.0)
                        if shuffle {
                            Image(systemName: "\(order[0]).square")
                        }
                    }
                    HStack{
                        TextField("お名前", text: $nameList.1)
                        if shuffle {
                            Image(systemName: "\(order[1]).square")
                        }
                    }
                    HStack{
                        if participant >= 3 {
                            TextField("お名前", text: $nameList.1)
                            if shuffle {
                                Image(systemName: "\(order[2]).square")
                            }
                        }
                    }
                    HStack{
                        if participant == 4 {
                            TextField("お名前", text: $nameList.1)
                            if shuffle {
                                Image(systemName: "\(order[3]).square")
                            }
                        }
                    }
                    
                }
                
                Button(action: {
                    if participant < 4 {participant += 1}
                }){
                    Text("\(btnStr)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .border(Color.gray, width: 5)
                }
            } // VS
            if shuffle {
                Image("透明")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {return}
            }
        }// ZS
    }
    func orderDecision() {
        for i in 1...participant {
            order.append(i)
        }
        shuffle = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            order.shuffle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            btnStr = "順番が決定しました。"
            timer?.invalidate()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            // 順番の配列を、参照し、順番通りpinsに登録
            // 次の画面並行
        }
    }
}

struct pinInfoSetView: View {
    var body: some View {
        ZStack{
            
        }
    }
}
