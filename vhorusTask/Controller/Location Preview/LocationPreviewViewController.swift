//
//  LocationPreviewViewController.swift
//  vhorusTask
//
//  Created by Sherif  Wagih on 10/20/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class LocationPreview: UIViewController {
    
    let dismissButton:UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(dismissControl), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let latLonAltLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = -1
        label.textAlignment = .center
        return label
    }()
    
    let goToGoogleMaps:UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(goToGoogleMapsApp), for: .touchUpInside)
        
        button.setTitle("Open in Maps", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var location : LocationObject?{
        didSet{
            guard let location = location else {return}
            latLonAltLabel.text = "Lat:\(location.lat!)\nLon:\(location.lon!)\nAlt:\(location.alt!)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        
    }
    func setupViews()
    {
        view.addSubview(latLonAltLabel)
        latLonAltLabel.anchorToView(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,padding: .init(top: 150, left: 0, bottom: 0, right: 0), size: .init(width:0,height:80))
        view.addSubview(goToGoogleMaps)
        goToGoogleMaps.anchorToView(top: latLonAltLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 15, left: 25, bottom: 0, right: 25), size: .init(width: 0, height: 50))
        view.addSubview(dismissButton)
        dismissButton.anchorToView(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor)
    }
    @objc func goToGoogleMapsApp()
    {
        if let UrlNavigation = URL.init(string: "comgooglemaps://") {
            if UIApplication.shared.canOpenURL(UrlNavigation){
                if location?.lon != nil && self.location?.lat != nil {
                    
                    let lat =    (self.location?.lat)!
                    let longi = (self.location?.lon)!
                    
                    if let urlDestination = URL.init(string: "comgooglemaps://?saddr=&daddr=\(lat),\(longi)&directionsmode=driving") {
                        UIApplication.shared.open(urlDestination, options: [:])
                    }
                }
            }
            else {
                NSLog("Can't use comgooglemaps://");
                self.openTrackerInBrowser()
            }
        }
        else
        {
            NSLog("Can't use comgooglemaps://");
            self.openTrackerInBrowser()
        }
    }
    func openTrackerInBrowser(){
        if self.location?.lon != nil && self.location?.lat != nil {
            
            let lat = (self.location?.lat)!
            let longi = (self.location?.lon)!
            
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(longi)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination, options: [:])

            }
        }
    }
    @objc func dismissControl()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
