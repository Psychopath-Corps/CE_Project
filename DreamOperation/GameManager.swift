//
//  GameManager.swift.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/17.
//

import SwiftUI

class GameManager: ObservableObject {
    
    @Published var pins:[(num: Int, name: String, color: String, style: String,
                          place: Int, money: Int, health: Int,
                          salary: Int, pay: Int, follow1: String, follow2: String)] = []
    
    @Published var stepPosi: [(x:CGFloat, y: CGFloat)] = []
    @Published var isPosi = false
    
    @Published var mapPosi = (x: CGFloat(0), y: CGFloat(0))
    // stepの座標に合わせる
    @Published var pin1 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pin2 = (x: CGFloat(0), y: CGFloat(0))
    @Published var pinposi = (a: 0,b: 0,c: 0,d: 0)
    @Published var playing = 1
    
    /// サイコロロジック
    func saicoro(max: Int) -> Int {
        let saicoro = Int.random(in: 1...max)
        return saicoro
    }
    
}
