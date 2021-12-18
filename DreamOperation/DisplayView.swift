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
        OpeningView()
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
