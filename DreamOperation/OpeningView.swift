//
//  OpeningView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct OpeningView: View {
    @ObservedObject var data: Observer = .data
    var body: some View {
        ZStack{
            VStack{
                Text("オープニング")
                Button("PLAY"){
                    self.data.display = "Setting"
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
