//
//  ortalamaHesaplaGosterApp.swift
//  ortalamaHesaplaGoster
//
//  Created by Bora Erdem on 23.07.2022.
//

import SwiftUI

@main
struct ortalamaHesaplaGosterApp: App {

    @StateObject var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
            }.environmentObject(vm)
        }
    }
}
