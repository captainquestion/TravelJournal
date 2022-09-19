//
//  ViewController.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-08.
//

import UIKit
import CoreData
var personList = [PersonEntity]()
class ViewController:UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var modelView = ModelView()
    var firstLoad = true
    
    
    var deleteBool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        modelView.fetchData()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20) / 2, height: self.collectionView.frame.size.height / 3)
        collectionView.reloadData()
        
        title = "The Travel Journal"
        
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        if deleteBool == false{
            deleteBool = true
            collectionView.reloadData()
            
        }else {
            deleteBool = false
            collectionView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
        
        
    }
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        let thisPerson: PersonEntity!
        thisPerson = modelView.nonDeletedNotes()[indexPath.row]
        
        
        cell.siteImageView.image = UIImage(data: thisPerson.value(forKey: "image1") as! Data)
        cell.titleLbl.text = (thisPerson.value(forKey: "name") as? String)!
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        if deleteBool == true{
            cell.siteImageView.alpha = 0.5
        }else {
            cell.siteImageView.alpha = 1
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return modelView.nonDeletedNotes().count
    }
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 300)
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        if deleteBool == true{
            
            
            let alert = UIAlertController(title: "Delete Mode", message: "Are you sure about deleting ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                print("Yes'e bastim")
                
                self.modelView.delete(indexPathRow: indexPath.row)
                
                collectionView.reloadData()
                self.deleteBool = false
                
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive))
            present(alert, animated: true)
            
            
            collectionView.reloadData()
            deleteBool = false
            
            
            
        }else{
            
            
            let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
            
            let selectedPerson : PersonEntity!
            selectedPerson = modelView.nonDeletedNotes()[indexPath.row]
            
            
            
            
            vc.indexPath =  Int(indexPath.row)
            vc.lat = (selectedPerson.value(forKey: "lat") as? Double)!
            vc.lon = (selectedPerson.value(forKey: "lon") as? Double)!
            vc.text = (selectedPerson.value(forKey: "name") as? String)!
            vc.imageVal1 = UIImage(data: selectedPerson.value(forKey: "image1") as! Data)
            vc.imageVal2 = UIImage(data: selectedPerson.value(forKey: "image2") as! Data)
            vc.imageVal3 = UIImage(data: selectedPerson.value(forKey: "image3") as! Data)
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}




