//
//  ViewBox.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI

struct mapView: View {
    let w = UIScreen.main.bounds.width
    var body: some View {
        ZStack{
            ForEach(1..<21) { num in
                image(num: num)
            }
        }.frame(width: w*4, height: w*2)
    }
}

struct image: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let num: Int
    var body: some View {
        ZStack{
            Image("green")
                .resizable()
                .frame(width: w/5, height: w/7)
                .border(Color.black)
            Text("\(num)")
        }.position(x: w/5*CGFloat(num)-w/10, y: w/5-w/10)
    }
}
