//
//  GameManager.swift.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/17.
//

import SwiftUI

class GameManager: ObservableObject {
    /// サイコロロジック
    func saicoro(max: Int) -> Int {
        let saicoro = Int.random(in: 1...max)
        return saicoro
    }
}
