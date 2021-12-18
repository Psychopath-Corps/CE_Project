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
                        game.isMovingTurn.toggle()
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
