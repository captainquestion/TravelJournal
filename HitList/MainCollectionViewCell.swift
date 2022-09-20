//
//  MainCollectionViewCell.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-13.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var siteImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var imageVal: UIImage?
    var titleLblVal: String?

    func setup(image: UIImage, title: String){
        siteImageView.image = imageVal
        titleLbl.text = titleLblVal
    }
    
}
