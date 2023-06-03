//
//  SwiftUI_Study_MapMarkerApp.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import SwiftUI
import GoogleMaps

@main
struct SwiftUI_Study_MapMarkerApp: App {
    @StateObject var viewModel = PhotoViewModel()
    
    // 초기화 시 api key 전달
    init() {
        GMSServices.provideAPIKey(KEY.GM_API_KEY)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
