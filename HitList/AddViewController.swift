//
//  AddViewController.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-09.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var locSwitch: UISwitch!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var latText: UITextField!
    @IBOutlet weak var longText: UITextField!
    
    @IBOutlet weak var imgBtn1: UIButton!
    @IBOutlet weak var imgBtn2: UIButton!
    @IBOutlet weak var imgBtn3: UIButton!
    
    let manager = CLLocationManager()
    
    var selectedPerson: PersonEntity? = nil
    var modelView = ModelView()
    var currentImageIndex = 0

    var locationBool = false
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_3.jpeg")!)

        super.viewDidLoad()
        
        locSwitch.isOn = false
        nameText.delegate = self
        latText.delegate = self
        longText.delegate = self

        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func pickerFunc(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in
            
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {action in
           
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action:UIAlertAction) in
           
            
            
        }))
        present(actionSheet, animated: true, completion: nil)    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       
        guard let location = locations.first else{
            return
            
        }
        
        if(locationBool == true){
            manager.startUpdatingLocation()
          
            
            latText.text = String(location.coordinate.latitude)
            longText.text = String(location.coordinate.longitude)
        }else {
            manager.stopUpdatingLocation()
            latText.text = ""
            longText.text = ""
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if (currentImageIndex == 0) {
                imageView1.contentMode = .scaleToFill
                imageView1.image = pickedImage
                imgBtn1.isHidden = true
                currentImageIndex = 1
            } else if (currentImageIndex == 1) {
                imageView2.contentMode = .scaleToFill
                imageView2.image = pickedImage
                imgBtn2.isHidden = true
                currentImageIndex = 2
            } else if (currentImageIndex == 2) {
                imageView3.contentMode = .scaleToFill
                imageView3.image = pickedImage
                imgBtn3.isHidden = true
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        if sender.isOn == true{
            print("Switch ON")
            manager.startUpdatingLocation()
            locationBool = true
            
        }else {
            locationBool = false
        }
    }
    
    
    
    
    @IBAction func imageBtn1(_ sender: Any) {
        pickerFunc()
    }
    
    @IBAction func imageBtn2(_ sender: Any) {
        pickerFunc()
       
    }
    @IBAction func imageBtn3(_ sender: UIButton) {
        pickerFunc()
    }
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        if (nameText.text == "" || latText.text == "" || longText.text == "" || imageView1.image?.pngData()?.isEmpty == true || imageView2.image?.pngData()?.isEmpty == true || imageView3.image?.pngData()?.isEmpty == true ){
            
            let alert = UIAlertController(title: "Error !", message: "Please fill all the blank fields and images", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            present(alert, animated: true)
        }else {
            
            if((Double(latText.text!)! <= 90.0 && Double(latText.text!)! >= -90.0) || (Double(longText.text!)! <= 180.0 && Double(longText.text!)! >= -180.0)){
                modelView.save(id: personList.count as NSNumber, name: nameText.text!, lat: Double(latText.text!)!, lon: Double(longText.text!)!, image1: (imageView1.image?.pngData()!)!, image2: (imageView2.image?.pngData()!)!, image3: (imageView3.image?.pngData()!)!)
                navigationController?.popViewController(animated: true)
            }else {
                let alert2 = UIAlertController(title: "Error!", message: "Please enter valid values.", preferredStyle: .alert)
                alert2.addAction(UIAlertAction(title: "OK", style: .cancel))
                
                present(alert2, animated: true)
            }
            
        }
        
    }
}




