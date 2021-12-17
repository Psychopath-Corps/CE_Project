//
//  SettingView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var data: Observer = .data
    var body: some View {
        ZStack{
            VStack{
                Text("設定")
                Button("PLAY"){
                    self.data.display = "Play"
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
