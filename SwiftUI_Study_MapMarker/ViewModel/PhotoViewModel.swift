//
//  PhotoViewModel.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/27.
//

import UIKit
import CoreLocation

/**
 기본 사진앱에서 가져온 이미지의 정보를 저장하기 위한 모델
 */
struct ImageData: Identifiable {
    var id = UUID()
    var image: UIImage?
    var date: Date?
    var location: CLLocationCoordinate2D?
}

class PhotoViewModel: ObservableObject {
    @Published var imageData: [ImageData] = []
}
