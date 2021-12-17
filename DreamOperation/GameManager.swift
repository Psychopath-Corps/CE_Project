//
//  GameManager.swift.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/17.
//

import SwiftUI

class GameManager: ObservableObject {
    @Published var display = "Opening"
    
    @Published var pins:[(num: Int, name: String, color: String, style: String,
                          place: Int, money: Int, health: Int,
                          salary: Int, pay: Int, follow1: String, follow2: String)] = []
}
