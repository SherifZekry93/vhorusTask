//
//  ViewController.swift
//  vhorusTask
//
//  Created by Sherif  Wagih on 10/20/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout
    {
    
    let locationManager = CLLocationManager();
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var allLocations:[LocationObject] = [LocationObject]()
    let getLocationButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get My location", for: .normal)
        button.addTarget(self, action: #selector(requestLocationAccess), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchLocations()
        setupViews()
        setupCollectionView()
        fixTopSaveArea()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func fixTopSaveArea()
    {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else {return}
            let hideTopSafeAreaview = UIView()
            hideTopSafeAreaview.backgroundColor = .blue
            window.addSubview(hideTopSafeAreaview)
            hideTopSafeAreaview.anchorToView(top: window.topAnchor, left: window.leftAnchor, bottom: self.getLocationButton.topAnchor, right: window.rightAnchor)
        }
       
    }
    
    func fetchLocations()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationObject")
        
        do
        {
            let result = try context.fetch(request)
            for data in result {
                guard let location = data as? LocationObject else {return}
                allLocations.append(location)
            }
            self.collectionView.reloadData()
        }
        catch {
            
            print("Failed")
        }

    }
    
    
    
    func updateAndSaveLocation(lat:String,lon:String,altitude:CLLocationDistance)
    {
        print("Start saving",lat,lon,String(altitude))
        
        let locObject = LocationObject(context:context)
        locObject.lat = lat
        locObject.lon = lon
        locObject.alt = String(altitude)
        do
        {
            self.collectionView?.performBatchUpdates({
                let indexPath = IndexPath(row: self.allLocations.count, section: 0)
                self.allLocations.append(locObject)
                self.collectionView.insertItems(at: [indexPath])
            }, completion: nil)
            try context.save()
        }
        catch 
        {
            print("error saving")
        }
    }
    
    func displayError(error : String)
    {
        // create the alert
        let alert = UIAlertController(title: "Error!", message: error, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func setupViews()
    {
        view.addSubview(getLocationButton)
        getLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        getLocationButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        getLocationButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        getLocationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupCollectionView()
    {
        collectionView.backgroundColor = .lightGray
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: "ID")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! LocationCell
        cell.location = allLocations[indexPath.item]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: 210)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLocations.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationPreview = LocationPreview()
        locationPreview.location = allLocations[indexPath.item]
        present(locationPreview, animated: true, completion: nil)
    }
}

