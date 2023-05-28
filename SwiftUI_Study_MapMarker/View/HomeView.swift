//
//  HomeView.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: PhotoViewModel
    
    var body: some View {
        TabView {
            MapViewRepresentable()
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
            AlbumView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("앨범")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
