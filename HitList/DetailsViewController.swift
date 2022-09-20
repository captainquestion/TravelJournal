//
//  DetailsViewController.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-10.
//

import UIKit
import CoreLocation
import MapKit

class DetailsViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    //instance for using the MapKit
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var modelView = ModelView()
    var indexPath = 0
    var lat = 0.0
    var lon = 0.0
    var text = ""
    var imageVal1: UIImage?
    var imageVal2: UIImage?
    var imageVal3: UIImage?
    var imageArray: [UIImage] = []
    
    
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_3.jpeg")!)

        title = text
        // Appending imageArray with the image values provided
        addImage(image1: imageVal1, image2: imageVal2, image3: imageVal3)
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    func addImage(image1: UIImage?, image2: UIImage?, image3: UIImage?){
        imageArray.append(image1!)
        imageArray.append(image2!)
        imageArray.append(image3!)
        
        collectionView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

        //calling goToMap with given latitude and longitude
        goToMap(lat: lat, lon: lon)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Instance of the cell within the collection view. cell's image is equal to the imageArray provided by the ViewController
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImageCell", for: indexPath) as! DetailImageCell
        cell.detail_image.image = imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Upon clicking images, user is prompted to see the image in PhotoDetailsVC view which has the function of rotating the image
        let image = imageArray[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "PhotoDetailsVCID") as! PhotoDetailsVC
        
        vc.imageVal = image
        vc.textImageTitle = text
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    
    func goToMap(lat: Double, lon: Double){
        //taking location parameters and assign it as CLLocation
        let location = CLLocation(latitude: lat, longitude: lon)
        //changing the CLLocation instance into CLLocationCoordinate2D
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //determining the zoom rate
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        //setting the region
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        //adding a annotation pin to the given region
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    


}
