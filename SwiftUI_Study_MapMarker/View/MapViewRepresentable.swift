//
//  MapViewRepresentable.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import SwiftUI
import GoogleMaps

struct MapViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var viewModel: PhotoViewModel
    
    let mapView = GMSMapView()
    let locationManager = LocationManager()
    
    // MARK: - Create & Update view
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isUserInteractionEnabled = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        // 유저의 현재 위치 가져오기, Camera 위치 설정
        let location = locationManager.getCurrentLocation()
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        mapView.camera = camera
        
        return mapView
    }
    
    // view model 변경 시 호출됨
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.addMarkers()    // 마커 추가 함수 호출
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
}

extension MapViewRepresentable {
    class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        // MARK: - Properties
        var parent: MapViewRepresentable
        
        // MARK: - Life cycle
        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }
        
        // MARK: - GMSMapViewDelegate
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            //      let marker = GMSMarker(position: coordinate)
            //      self.mapView.polygonPath.append(marker)
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//            self.mapView.onAnimationEnded()
        }
        
        // MARK: - Helpers
        func addMarkers() {
            for data in parent.viewModel.imageData {
                // imageData의 위치, 이미지 사용
                guard let location = data.location, let iconImage = data.image else {
                    continue
                }
                
                // 위치 좌표 출력
                print("Marker At: \(location.latitude), \(location.longitude)")
                
                // Marker
                let marker = GMSMarker(position: location)
                
                // marker icon image view
                let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                iconImageView.image = iconImage
                iconImageView.contentMode = .scaleAspectFill
                iconImageView.layer.borderWidth = 2
                iconImageView.layer.borderColor = UIColor.white.cgColor
                iconImageView.layer.cornerRadius = 8
                iconImageView.layer.masksToBounds = true    // 이미지도 둥글게
                marker.iconView = iconImageView
                
                marker.map = parent.mapView
            }
            
        }
    }
}
