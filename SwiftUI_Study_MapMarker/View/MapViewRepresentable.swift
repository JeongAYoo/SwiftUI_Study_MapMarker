//
//  MapViewRepresentable.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import SwiftUI
import GoogleMaps

struct MapViewRepresentable: UIViewRepresentable {
    
    let mapView = GMSMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isUserInteractionEnabled = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
}

extension MapViewRepresentable {
    class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapView: MapViewRepresentable
        
        init(_ mapView: MapViewRepresentable) {
            self.mapView = mapView
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            //      let marker = GMSMarker(position: coordinate)
            //      self.mapView.polygonPath.append(marker)
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//            self.mapView.onAnimationEnded()
        }
    }
}
