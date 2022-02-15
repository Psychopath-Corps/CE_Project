//
//  DisplayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct DisplayView: View {
    @ObservedObject var game: GameManager = .game
    var body: some View {
        if game.display == "Opening" {
            OpeningView()
        } else if game.display == "Setting" {
            SettingView()
        } else if game.display == "Play" {
            ZStack{
                PlayView(dice: $game.diceroll)
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
        } else if game.display == "game" {
            
        } else if game.display == "setting" {
            
        } else if game.display == "" {
            
        } else if game.display == "" {
            
        } else {
            
        }
        
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
