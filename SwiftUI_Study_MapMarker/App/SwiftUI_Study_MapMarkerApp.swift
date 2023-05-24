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
    init() {
        GMSServices.provideAPIKey(KEY.GM_API_KEY)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
