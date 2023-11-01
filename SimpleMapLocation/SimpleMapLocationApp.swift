//
//  SimpleMapLocationApp.swift
//  SimpleMapLocation
//
//  Created by Kentaro Mihara on 2023/11/01.
//

import SwiftUI

@main
struct SimpleMapLocationApp: App {
    @StateObject var viewModel = ViewModel(model: LocationDataSource())
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
