//
//  SettingView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

/// 三種類のViewの表示の管理
struct SettingView: View {
    @ObservedObject var game: GameManager = .game
    
    var body: some View {
        ZStack{
            Image("oldPaper")
                .resizable()
                .edgesIgnoringSafeArea(.all)
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
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
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
                
                // 縦積み最大4人分の名前を登録するTextField
                Group{
                    HStack{
                        TextField("お名前", text: $nameList[0])
                            .frame(width: w/2, height: h/10)
                            .border(Color.black)
                        if shuffle {
                            Image(systemName: "1.square")
                                .resizable()
                                .frame(width: h/10, height: h/10)
                        }
                    }
                    HStack{
                        TextField("お名前", text: $nameList[1])
                            .frame(width: w/2, height: h/10)
                            .border(Color.black)
                        if shuffle {
                            Image(systemName: "2.square")
                                .resizable()
                                .frame(width: h/10, height: h/10)
                        }
                    }
                    HStack{
                        if nameList.count >= 3 {
                            TextField("お名前", text: $nameList[2])
                                .frame(width: w/2, height: h/10)
                                .border(Color.black)
                            if shuffle {
                                Image(systemName: "3.square")
                                    .resizable()
                                    .frame(width: h/10, height: h/10)
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
                                    .resizable()
                                    .frame(width: h/10, height: h/10)
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
        for i in 0..<nameList.count {
            game.pins.append((num: i, name: "", color: "黒", style: "ワイシャツ", place: 0, money: 10000, health: 5, dream: "", needMoney: 5000000, salary: 0, pay: 0, follow1: "", follow2: ""))
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
    var body: some View {
        ZStack{
            
            HStack(spacing: 20){
                
                VStack(spacing: 0){
                    Spacer()
                    pinSkin(num: game.playing, size: 1)
                    Text("\(game.pins[game.playing].name)")
                    Spacer().frame(height: 10)
                }.frame(width: w/5)
                
                VStack(spacing: 3){
                    
                    Text("色を選んでください")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                    // 1列目
                    HStack(spacing: 3){
                        ForEach(0..<4){ num in
                            buttonOfColorSetting(colorNum: num)
                        }
                    }
                    // 2列目
                    HStack(spacing: 3){
                        ForEach(4..<8){ num in
                            buttonOfColorSetting(colorNum: num)
                        }
                    }
                    
                    Text("\n服を選んでください")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                    // 1列目
                    HStack(spacing: 3){
                        ForEach(0..<4){ num in
                            buttonOfStyleSetting(styleNum: num)
                        }
                    }
                    // 2列目
                    HStack(spacing: 3){
                        ForEach(4..<8){ num in
                            buttonOfStyleSetting(styleNum: num)
                        }
                    }
                }.frame(width: w/5)
                
                VStack{
                    Text("\(game.pins[game.playing].name)、夢は？")
                        .font(.system(.title3, design: .serif))
                    TextField("\(game.pins[game.playing].name) の 夢",
                              text: $game.pins[game.playing].dream)
                        .frame(width: 150, height: 30)
                        .border(Color.black)
                    
                    Text("\n夢の目標金額")
                        .font(.system(.title3, design: .serif))
                    
                    ForEach(0..<4){ num in
                        buttonOfNeedMoneySetting(num: num)
                    }
                }.frame(width: w/5)
                
                VStack{
                    
                    Text("色：\(game.pins[game.playing].color)")
                    Text("服：\(game.pins[game.playing].style)")
                    Text("夢：\(game.pins[game.playing].dream)")
                    Text("目標金額：\(game.pins[game.playing].needMoney)")
                    Text("スコア倍率：")
                    
                    Button(action: {
                        decision()
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
    func decision() {
        // 夢の入力を確認
        if game.pins[game.playing].dream != "" {
            game.playing += 1
            // 登録するのが最後の人かどうかをチェック
            if game.playing == game.pins.count {
                // 次の人がいない場合
                game.settingDisp = "loading"
                game.playing = 0
            }
        }
    }
}

// ForEachでピンの色を変更するボタンを表示させる
struct buttonOfColorSetting: View {
    @ObservedObject var game: GameManager = .game
    let colorNum: Int
    let colorList = ["赤", "青", "緑", "黄", "紫", "桃", "橙", "黒"]
    let colorMod = [Color.red, Color.blue, Color.green, Color.yellow,
                    Color.purple, Color.pink, Color.orange, Color.black]
    
    var body: some View {
        Button(action: {
            game.pins[game.playing].color = colorList[colorNum]
        }){
            Text("\(colorList[colorNum])")
                .frame(width: 50, height: 50)
                .foregroundColor(Color.white)
                .background(colorMod[colorNum])
                .border(Color.black)
                .cornerRadius(5)
        }
    }
}
// ForEachでピンの服を変更するボタンを表示させる
struct buttonOfStyleSetting: View {
    @ObservedObject var game: GameManager = .game
    let styleNum: Int
    let styleList = ["ワイシャツ", "コート男", "バカトレーナー", "バカTシャツ",
                     "制服男", "制服女", "スカート", "可愛い"]
    var body: some View {
        Button(action: {
            game.pins[game.playing].style = styleList[styleNum]
        }){
            Image("\(styleList[styleNum])")
                .resizable()
                .frame(width: 50, height: 50)
                .border(Color.black)
                .cornerRadius(5)
        }
    }
}
// ForEachで目標金額を変更するボタンを表示させる
struct buttonOfNeedMoneySetting: View {
    @ObservedObject var game: GameManager = .game
    let num: Int
    let valueList = [10000000, 7500000, 5000000, 2500000]
    let valueListStr = ["¥10,000,000", "¥7,500,000", "¥5,000,000", "¥2,500,000"]
    var body: some View {
        HStack{
            HStack{
                Button(action: {
                    game.pins[game.playing].needMoney = valueList[num]
                }){
                    Text("\(valueListStr[num])")
                        .italic()
                        .foregroundColor(Color.black)
                        .frame(width: 100, height: 30)
                        .background(Color.white)
                        .border(Color.black)
                }
                if game.pins[game.playing].needMoney==valueList[num] {
                    Image(systemName: "arrowtriangle.left.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

/// 5秒のカウントの後、playViewに移行
struct LoadingView: View {
    @ObservedObject var game: GameManager = .game
    @State var timer: Timer!
    @State var count = 5
    var body: some View {
        ZStack{
            VStack{
                Button(action: {game.display = "Play"}){
                    Text("Play")
                }
                HStack(spacing: 30){
                    ForEach(0..<game.pins.count){ i in
                        VStack{
                            Text("\(game.pins[i].name)")
                            Text("夢：\(game.pins[i].dream)")
                            //Text("¥\(game.pins[0].needMoney)")
                            pinSkin(num: i, size: CGFloat(0.7))
                        }
                    }
                   
                }
                Text("開始まで\(count)秒")
            }
        }.onAppear(){start()}
    }
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            count -= 1
            if count == 0 {
                stop()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        game.display = "Play"
    }
}
