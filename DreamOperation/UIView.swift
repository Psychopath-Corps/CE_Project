//
//  UIView.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct UIView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image("pinImage")
                    .resizable()
                    .frame(width: 20, height: 40)
                Image("pinImage")
                    .resizable()
                    .frame(width: 20, height: 40)
                Image("pinImage")
                    .resizable()
                    .frame(width: 20, height: 40)
                Image("pinImage")
                    .resizable()
                    .frame(width: 20, height: 40)
            }
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("♡ 8")
                    Text("¥ 768,868")
                }
            }
            Spacer().frame(height: 10)
        }
    }
}

struct UIView_Previews: PreviewProvider {
    static var previews: some View {
        UIView()
    }
}
