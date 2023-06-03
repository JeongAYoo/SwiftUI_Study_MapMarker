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
    
    /// 화면크기의 1/3
    let imageWidth = UIScreen.main.bounds.width / 3
    /// 그리드에 나타낼 컬럼
    /// spacing을 0으로, 대신 이미지에 보더 설정
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.imageData, id: \.self.id) { imageData in
                        if let newImage = imageData.image {
                            Image(uiImage: newImage)
                                .resizable()
                                .frame(width: imageWidth, height: imageWidth)
                                .scaledToFit()
                                .border(.white)
                        }
                    }
                }
            }
            .navigationTitle("Album")
            .toolbar {
                // navigation button
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
