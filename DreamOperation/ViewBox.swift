//
//  ViewBox.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI


struct box: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let posi: (x:CGFloat, y: CGFloat)
    let n: Int
    var body: some View {
        ZStack{
            Text("\(n)")
                .frame(width: w/10, height: w/10)
                .background(Color.gray)
                .border(Color.green)
                .position(x: posi.x, y: posi.y)
        }
    }
}
