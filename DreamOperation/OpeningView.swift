//
//  OpeningView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct OpeningView: View {
    @ObservedObject var game: GameManager = .game
    
    var body: some View {
        ZStack{
            VStack{
                Text("オープニング")
                Button("PLAY"){
                    game.isMovingSetting.toggle()
                }
                // 設定画面に画面遷移
                .fullScreenCover(isPresented: $game.isMovingSetting){
                    SettingView(isMovingSetting: $game.isMovingSetting)
                }
            }
        }
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
    }
}
