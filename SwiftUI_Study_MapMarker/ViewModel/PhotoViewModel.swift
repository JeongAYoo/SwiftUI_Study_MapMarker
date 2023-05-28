//
//  PhotoViewModel.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/27.
//

import UIKit
import CoreLocation

struct ImageData: Identifiable {
    var id = UUID()
    var image: UIImage?
    var date: Date?
    var location: CLLocationCoordinate2D?
}

class PhotoViewModel: ObservableObject {
    @Published var imageData: [ImageData] = []
}
