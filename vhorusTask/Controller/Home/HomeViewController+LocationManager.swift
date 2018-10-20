//
//  HomeViewController+LocationManager.swift
//  vhorusTask
//
//  Created by Sherif  Wagih on 10/20/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreLocation
extension HomeViewController:CLLocationManagerDelegate
{
    @objc func requestLocationAccess()
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation();
            locationManager.delegate = nil;
            let latitude = "\(location.coordinate.latitude)";
            let longtitude = "\(location.coordinate.longitude)";
            let altitude = location.altitude
            updateAndSaveLocation(lat: latitude, lon: longtitude, altitude: altitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        displayError(error: "Location is unavailable!")
    }
    
}
