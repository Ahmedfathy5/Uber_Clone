//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Ahmed Fathi on 25/01/2024.
//

import SwiftUI

@main
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
