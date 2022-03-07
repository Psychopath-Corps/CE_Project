//
//  DreamOperationApp.swift
//  DreamOperation
//
//  Created by cmStudent on 2021/12/14.
//

import SwiftUI
import Firebase

@main
struct DreamOperationApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            DisplayView()
            //mapView()
//            dice()
            //playerNameSetView()
            //pinInfoSetView()
            //PlayView()
            //SettingView()
        }
    }
}
