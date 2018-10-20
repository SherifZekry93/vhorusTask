//
//  LocationCell.swift
//  vhorusTask
//
//  Created by Sherif  Wagih on 10/20/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class LocationCell: UICollectionViewCell {
    var location:LocationObject?{
        didSet{
            guard let location = location else {return}
            locationNameLatLonAlt.text = "Lat:\(location.lat!)\nLon:\(location.lon!)\nAlt:\(location.alt!)"
        }
    }
    let locationImage:UIImageView = {
        let image = UIImageView(image: UIImage(named: "location-logo"))
        return image
    }()
    
    let locationNameLatLonAlt:UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = -1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
        backgroundColor = .white
    }
    func setupViews()
    {
        addSubview(locationImage)
        addSubview(locationNameLatLonAlt)
        locationImage.anchorToView(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 100))
        locationNameLatLonAlt.anchorToView(top: locationImage.bottomAnchor, left: locationImage.leftAnchor, bottom: bottomAnchor, right: locationImage.rightAnchor)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
