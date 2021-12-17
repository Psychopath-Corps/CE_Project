//
//  DisplayView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct DisplayView: View {
    @ObservedObject var data = GameManager()
    var body: some View {
        ZStack{
            if data.display == "Opening" {
                OpeningView()
            }
            if data.display == "Setting" {
                SettingView()
            }
            if data.display == "Play" {
                PlayView()
                UIView()
            }
            if data.display == "Debug" {
                PlayView()
            }
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
