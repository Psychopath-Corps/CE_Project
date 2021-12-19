//
//  TurnView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/18.
//

import SwiftUI

struct TurnView: View {
    @ObservedObject var game: GameManager = .game
    @Binding var isMoving: Bool
    var body: some View {
        Text("〇〇が歩むターンです")
        // 2回目以降に実行する処理
        if game.two == true {
            Text("交代してください")
        }
        Button("OK"){
            // 2回目以降に実行する処理
            if game.two == true{
                // 次のプレイヤーの位置まで移動す流処理
                if game.pinNumber == 0 {
                    game.pinNumber = 1
                } else if game.pinNumber == 1 {
                    game.pinNumber = 0
                }
                game.pinXY(a: game.pinNumber)
            }
            game.gamen = "play"
            // フルスクリーンカバーを解除する
            isMoving = false
            game.eventGamen = false
            // 半透明から透明に
            game.clearView = 0.0
            game.appear = false
        }
    }
}
