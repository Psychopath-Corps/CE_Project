//
//  SettingView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var game: GameManager = .game
    @Binding var isMovingSetting: Bool
    
    var body: some View {
        ZStack{
            if game.gamen == "setting" {
                VStack{
                    Text("設定")
                    Button("PLAY"){
                        game.isMoving.toggle()
                    }
                    .fullScreenCover(isPresented: $game.isMoving){
                        TurnView(isMoving: $game.isMoving)
                    }
                }
            } else if game.gamen == "play" {
                PlayView()
                UIView()
                if game.diceroll {
                    dice()
                        .background(Color.white.opacity(game.clearView))
                }
                if game.eventGamen {
                    event()
                        .background(Color.white.opacity(game.clearView))
                }
            }
        }
    }
}
