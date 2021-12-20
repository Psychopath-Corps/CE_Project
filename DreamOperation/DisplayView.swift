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
            SettingView(isMovingSetting: $game.isMovingSetting)
        } else if game.display == "Play" {
            PlayView()
        } else if game.display == "" {
            
        } else if game.display == "" {
            
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
