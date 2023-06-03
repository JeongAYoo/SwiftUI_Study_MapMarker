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
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isUserInteractionEnabled = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        let location = locationManager.getCurrentLocation()
        print(location)
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        mapView.camera = camera
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.addMarkers()
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
            // Test markers
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: +40.75921100, longitude: -73.98463800)
//            marker.icon = GMSMarker.markerImage(with: .red)
//            marker.map = parent.mapView
                        
            for data in parent.viewModel.imageData {
                guard let location = data.location, let iconImage = data.image else {
                    continue
                }
                print("Marker At: \(location.latitude), \(location.longitude)")
                
                let marker = GMSMarker(position: location)
                
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
