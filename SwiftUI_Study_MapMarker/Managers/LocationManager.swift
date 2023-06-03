//
//  LocationManager.swift
//  SwiftUI_Study_MapMarker
//
//  Created by Jade Yoo on 2023/05/24.
//

import CoreLocation

/**
 유저의 현재 위치 정보를 가져오기 위한 클래스
 */
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // 권한 요청
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
    }
    
    func getCurrentLocation() -> CLLocation {
        return locationManager.location ?? CLLocation(latitude: 37.566508, longitude: 126.977945)
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()  // 위치 업데이트 멈춤
    }
}
