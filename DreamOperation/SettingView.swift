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
            } else {
                
            }
            
            VStack{
                Text("設定")
                Button("PLAY"){
                    game.display = "Play"
                }
            }
            
        }
    }
}

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
        }
    }
    
    func nameRegister() {
        //game.pins[order[0]].name = nameList.0
    }
}

struct pinInfoSetView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @State var dream = ""
    @State var needMoney = 5000000
    var body: some View {
        ZStack{
            Group{
                Image("pin")
                    .resizable()
                    .frame(width: h*0.35, height: h*0.7)
                    .position(x: w/8, y: h*0.4)
                Image("Wshirts")
                    .resizable()
                    .frame(width: h*0.35, height: h*0.35)
                    .position(x: w/8, y: h*0.4)
            }
            
            HStack{
                VStack{
                    Spacer()
                    Text("佐野　炭治郎")
                    Spacer().frame(height: 10)
                }.frame(width: w/5)
                
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
                        Button(action: {}){
                            Text("服4")
                                .frame(width: 30, height: 30)
                                .background(Color.blue)
                                .border(Color.black)
                        }
                    }
                    HStack{
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
