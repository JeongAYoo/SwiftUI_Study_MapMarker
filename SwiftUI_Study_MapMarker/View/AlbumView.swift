//
//  AlbumView.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import SwiftUI
import PhotosUI

struct AlbumView: View {
    @StateObject var viewModel = TravelImageViewModel()
    @State var showSheet = false
    @State var selectedImage: UIImage?
    @State var date: Date?
    @State var location: CLLocationCoordinate2D?
    
    let imageWidth = UIScreen.main.bounds.width / 3 - 3
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let location = location {
                    Text("Location: latitude \(location.latitude) longitude \(location.longitude)")
                }
                LazyVGrid(columns: columns) {
                    ForEach(1..<100) { image in
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: imageWidth, height: imageWidth)
                            .scaledToFill()
                    }
                }
            }
            .navigationTitle("Album")
            .toolbar {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }.sheet(isPresented: $showSheet) {
                    PhotoPickerView(selectedImage: $selectedImage, date: $date, location: $location)
                }
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
