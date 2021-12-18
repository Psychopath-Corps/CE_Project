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
        Text("交代してください")
        Button("OK"){
            game.gamen = "play"
            // フルスクリーンカバーを解除する
            isMoving.toggle()
        }
    }
}
