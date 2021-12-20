//
//  SettingView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

let w = UIScreen.main.bounds.width
let h = UIScreen.main.bounds.height

struct SettingView: View {
    @ObservedObject var game: GameManager = .game
    
    var body: some View {
        ZStack{
            VStack{
                Text("設定")
                Button("PLAY"){
                    game.display = "Play"
                    //game.isMovingTurn = true
                    //safeAreaの値を取得
                    let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets.left
                    if(safeAreaInsets! >= 44.0){
                        game.dragOffset = CGSize(width: game.w/2 - 44, height: -game.w * 0.75 - 27)
                    } else {
                        game.dragOffset = CGSize(width: game.w/2, height: -game.w * 0.75)
                    }
                    game.pinClear[1] = 0.5
                }
            }
            
        }
    }
}

struct playerNameSetView: View {
    @ObservedObject var game: GameManager = .game
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
                        .font(.largeTitle)
                    Button(action: {
                        if participant > 2 {participant -= 1}
                    }){
                        Image(systemName: "arrowtriangle.left.fill")
                    }
                    Text("\(participant)")
                    Button(action: {
                        if participant < 4 {participant += 1}
                    }){
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                } // HS
                
                Group{
                    HStack{
                        TextField("お名前", text: $nameList.0)
                            .frame(width: w/2, height: h/10)
                            .border(Color.black)
                        if shuffle {
                            Image(systemName: "\(order[0]).square")
                        }
                    }
                    HStack{
                        TextField("お名前", text: $nameList.1)
                            .frame(width: w/2, height: h/10)
                            .border(Color.black)
                        if shuffle {
                            Image(systemName: "\(order[1]).square")
                        }
                    }
                    HStack{
                        if participant >= 3 {
                            TextField("お名前", text: $nameList.2)
                                .frame(width: w/2, height: h/10)
                                .border(Color.black)
                            if shuffle {
                                Image(systemName: "\(order[2]).square")
                            }
                        }
                    }
                    HStack{
                        if participant == 4 {
                            TextField("お名前", text: $nameList.3)
                                .frame(width: w/2, height: h/10)
                                .border(Color.black)
                            if shuffle {
                                Image(systemName: "\(order[3]).square")
                            }
                        }
                    }
                    
                }
                /// 名前の中身が全部入った時に上に表示させる予定
                Button(action: {
                    if participant < 4 {participant += 1}
                    orderDecision()
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
    
    func nameRegister() {
        //game.pins[order[0]].name = nameList.0
    }
}

struct pinInfoSetView: View {
    @State var dream = ""
    @State var needMoney = 5000000
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    
                    VStack{
                        Image("pinImage")
                            .resizable()
                            .frame(width: 100, height: 200)
                        Text("佐野　炭治郎")
                    }
                    
                    VStack{
                        Text("色")
                        HStack{
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                        }
                        HStack{
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                        }
                        HStack{
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("青")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                        }
                        Text("服")
                        HStack{
                            Button(action: {}){
                                Text("服1")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("服2")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("服3")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                        }
                        HStack{
                            Button(action: {}){
                                Text("服4")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("服5")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("服6")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                        }
                        HStack{
                            Button(action: {}){
                                Text("服7")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("服8")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                            Button(action: {}){
                                Text("服9")
                                    .frame(width: 30, height: 30)
                                    .background(Color.blue)
                                    .border(Color.black)
                            }
                        }
                    }
                    
                    VStack{
                        Text("夢は？")
                        TextField("佐野　炭治郎　の夢", text: $dream)
                            .frame(width: 150, height: 30)
                        
                        Text("夢の目標金額")
                        
                        Button(action: {
                            needMoney = 10000000
                        }){
                            Text("¥10000000")
                                .foregroundColor(Color.black)
                                .frame(width: 100, height: 30)
                                .background(Color.white)
                                .border(Color.black)
                        }
                        Button(action: {
                            needMoney = 7500000
                        }){
                            Text("¥7500000")
                                .foregroundColor(Color.black)
                                .frame(width: 100, height: 30)
                                .background(Color.white)
                                .border(Color.black)
                        }
                        Button(action: {
                            needMoney = 5000000
                        }){
                            Text("¥5000000")
                                .foregroundColor(Color.black)
                                .frame(width: 100, height: 30)
                                .background(Color.white)
                                .border(Color.black)
                        }
                        Button(action: {
                            needMoney = 2500000
                        }){
                            Text("¥2500000")
                                .foregroundColor(Color.black)
                                .frame(width: 100, height: 30)
                                .background(Color.white)
                                .border(Color.black)
                        }
                        Button(action: {
                            needMoney = 1000000
                        }){
                            Text("¥1000000")
                                .foregroundColor(Color.black)
                                .frame(width: 100, height: 30)
                                .background(Color.white)
                                .border(Color.black)
                        }
                    }
                }
                
                Button(action: {
                    
                }){
                    Text("決定")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .border(Color.gray, width: 5)
                }
            }
        }
    }
}
