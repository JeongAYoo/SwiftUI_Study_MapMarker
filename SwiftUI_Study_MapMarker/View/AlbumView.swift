//
//  AlbumView.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import SwiftUI
import PhotosUI

struct AlbumView: View {
    @EnvironmentObject var viewModel: PhotoViewModel
    @State var showSheet = false
    
    let imageWidth = UIScreen.main.bounds.width / 3
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.imageData, id: \.self.id) { imageData in
                        if let newImage = imageData.image {
                            Image(uiImage: newImage)
                                .resizable()
                                .frame(width: imageWidth, height: imageWidth)
                                .scaledToFill()
                        }
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
                    PhotoPickerView()
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
