//
//  loginApp.swift
//  login
//
//  Created by Rushabh Dabhade on 23/02/24.
//

import SwiftUI

@main
struct loginApp: App {
    @StateObject var vm = regvm()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
