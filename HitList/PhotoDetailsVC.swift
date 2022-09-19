//
//  PhotoDetailsVC.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-12.
//

import UIKit

class PhotoDetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageVal: UIImage?
    var textImageTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = textImageTitle
        imageView.image = imageVal
    }
    
    @IBAction func rotatePressed(_ sender: UIBarButtonItem) {
        imageView.transform = imageView.transform.rotated(by: CGFloat(Double.pi / 2)) //90 degree


    }
    


}
