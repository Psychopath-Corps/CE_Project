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
            if game.settingDisp == "nameSetting" {
                playerNameSetView()
            } else if game.settingDisp == "pinInfoSetting" {
                pinInfoSetView()
            } else if game.settingDisp == "loading" {
                LoadingView()
            }
        }
    }
}

/// 人数、名前、順番を決定する画面
struct playerNameSetView: View {
    @ObservedObject var game: GameManager = .game
    @State var timer: Timer!
    @State var btnStr = "決定"
    @State var nameList: [String] = ["",""]
    @State var shuffle = false
    var body: some View {
        ZStack{
            
            VStack{
                // 実質Spacer
                Text("")
                    .font(.largeTitle)
                
                Group{
                    HStack{
                        TextField("お名前", text: $nameList[0])
                            .frame(width: w/2, height: h/10)
                            .border(Color.black)
                        if shuffle {
                            Image(systemName: "1.square")
                        }
                    }
                    HStack{
                        TextField("お名前", text: $nameList[1])
                            .frame(width: w/2, height: h/10)
                            .border(Color.black)
                        if shuffle {
                            Image(systemName: "2.square")
                        }
                    }
                    HStack{
                        if nameList.count >= 3 {
                            TextField("お名前", text: $nameList[2])
                                .frame(width: w/2, height: h/10)
                                .border(Color.black)
                            if shuffle {
                                Image(systemName: "3.square")
                            }
                        }
                    }
                    HStack{
                        if nameList.count == 4 {
                            TextField("お名前", text: $nameList[3])
                                .frame(width: w/2, height: h/10)
                                .border(Color.black)
                            if shuffle {
                                Image(systemName: "4.square")
                            }
                        }
                    }
                    
                }
                Spacer().frame(height: 50)
            } // VS
            
            VStack{
                Spacer().frame(height: 10)
                HStack{
                    Text("参加者")
                        .font(.largeTitle)
                    Button(action: {
                        if nameList.count > 2 {nameList.removeLast()}
                    }){
                        Image(systemName: "arrowtriangle.left.fill")
                    }
                    Text("\(nameList.count)")
                        .font(.largeTitle)
                    Button(action: {
                        if nameList.count < 4 {nameList.append("")}
                    }){
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                } // HS
                
                Spacer()
                /// 名前の中身が全部入った時に上に表示させる予定
                Button(action: {
                    if checkName() {
                        orderDecision()
                    }
                }){
                    Text("\(btnStr)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .border(Color.gray, width: 5)
                }
                Spacer().frame(height: 10)
            } // VS
            
            if shuffle {
                Image("透明")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {return}
            }
            
        }// ZS
    }
    
    func checkName() -> Bool {
        var judge = true
        for i in 0..<nameList.count {
            if nameList[i] == "" {
                judge = false
                break
            }
        }
        return judge
    }
    
    func orderDecision() {
        for i in 0...nameList.count {
            game.pins.append((num: i, name: "", color: "", style: "", place: 0, money: 10000, health: 5, salary: 0, pay: 0, follow1: "", follow2: ""))
        }
        shuffle = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            nameList.shuffle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            btnStr = "順番が決定しました。"
            timer?.invalidate()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            // 順番の配列を、参照し、順番通りpinsに登録
            for i in 0..<nameList.count {
                game.pins[i].name = nameList[i]
            }
            // 次の画面並行
            game.settingDisp = "pinInfoSetting"
        }
    }
    
}

/// いろ、ふく、夢を設定する画面
struct pinInfoSetView: View {
    @ObservedObject var game: GameManager = .game
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @State var dream = ""
    @State var needMoney = 5000000
    var body: some View {
        ZStack{
            
            HStack{
                VStack(spacing: 0){
                    Spacer()
                    pinSkin()
                    Text("佐野　炭治郎")
                    Spacer().frame(height: 10)
                }.frame(width: w/5)
                
                VStack(spacing: 0){
                    Text("色")
                    HStack(spacing: 0){
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("赤")
                                .frame(width: 50, height: 50)
                                .background(Color.red)
                                .border(Color.black)
                        }
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("青")
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .border(Color.black)
                        }
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("緑")
                                .frame(width: 50, height: 50)
                                .background(Color.green)
                                .border(Color.black)
                        }
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("黄")
                                .frame(width: 50, height: 50)
                                .background(Color.yellow)
                                .border(Color.black)
                        }
                    }
                    HStack(spacing: 0){
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("紫")
                                .frame(width: 50, height: 50)
                                .background(Color.purple)
                                .border(Color.black)
                        }
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("桃")
                                .frame(width: 50, height: 50)
                                .background(Color.pink)
                                .border(Color.black)
                        }
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("橙")
                                .frame(width: 50, height: 50)
                                .background(Color.orange)
                                .border(Color.black)
                        }
                        Button(action: {game.pins[game.playing].color = "黒"}){
                            Text("黒")
                                .frame(width: 50, height: 50)
                                .background(Color.black)
                                .border(Color.black)
                        }
                    }
                    
                    Text("服")
                    HStack(spacing: 0){
                        Button(action: {
                            game.pins[game.playing].style = "ワイシャツ"
                        }){
                            Image("ワイシャツ")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                        Button(action: {
                            game.pins[game.playing].style = "コート男"
                        }){
                            Image("コート男")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                        Button(action: {
                            game.pins[game.playing].style = "バカトレーナー"
                        }){
                            Image("バカトレーナー")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                        Button(action: {
                            game.pins[game.playing].style = "バカTシャツ"
                        }){
                            Image("バカTシャツ")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                    }
                    HStack(spacing: 0){
                        Button(action: {
                            game.pins[game.playing].style = "制服男"
                        }){
                            Image("制服男")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                        Button(action: {
                            game.pins[game.playing].style = "制服女"
                        }){
                            Image("制服女")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                        Button(action: {
                            game.pins[game.playing].style = "スカート"
                        }){
                            Image("スカート")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                        Button(action: {
                            game.pins[game.playing].style = "可愛い"
                        }){
                            Image("可愛い")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.black)
                        }
                    }
                }.frame(width: w/5)
                
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
                }.frame(width: w/5)
                
                VStack{
                    
                    Text("色：")
                    Text("服：")
                    Text("夢：")
                    Text("目標金額：")
                    Text("スコア倍率：")
                    
                    Button(action: {
                        game.settingDisp = "loading"
                    }){
                        Text("決定")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .border(Color.gray, width: 5)
                    }
                }.frame(width: w/5)
            }
        }
    }
}

struct LoadingView: View {
    @ObservedObject var game: GameManager = .game
    @State var timer: Timer!
    @State var count = 0
    var body: some View {
        ZStack{
            VStack{
                Button(action: {game.display = "Play"}){
                    Text("Play")
                }
                HStack{
                    VStack{
//                        Text("夢\(game.pins[0].dream)")
//                        Text("¥\(game.pins[0].needMoney)")
                        Image("pinsImage")
                            .resizable()
                            .frame(width: 100, height: 200)
                        Text("¥\(game.pins[0].name)")
                    }
                    VStack{
                        
                    }
                    if game.pins.count >= 3 {
                        VStack{
                            
                        }
                    }
                    if game.pins.count == 4 {
                        VStack{
                            
                        }
                    }
                }
                Text("開始まで\(count)秒")
            }
        }
    }
}
