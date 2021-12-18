//
//  OpeningView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct OpeningView: View {
    @State var isMoving = false
    var body: some View {
        ZStack{
            VStack{
                Text("オープニング")
                Button("PLAY"){
                    isMoving.toggle()
                }
                .fullScreenCover(isPresented: $isMoving){
                    SettingView(isMovingSetting: $isMoving)
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
