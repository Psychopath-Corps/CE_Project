//
//  OpeningView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct OpeningView: View {
    @ObservedObject var game: GameManager = .game
    @State var isMovingSetting = false
    var body: some View {
        ZStack{
            VStack{
                Text("オープニング")
                Button("PLAY"){
                    game.display = "Setting"
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
