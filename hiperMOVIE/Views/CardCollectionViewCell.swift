//
//  CollectionViewCell.swift
//  hiperMOVIE
//
//  Created by Miguel Alejandro Correa Avila on 12/7/23.
//

import UIKit
import Kingfisher

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  var image: UIImageView!
    @IBOutlet  var title: UILabel!
    @IBOutlet  var subtitle: UILabel!
    
    

    func configure (result:Result) {
        // TODO: check if this works
        
        
        
       title.text = result.title
//        self.subtitleLabel.text = result.subtitle
    }
    
//    func getImageFromKF(image:String) {
//        let image = KFImage(URL(string: result.image))
//
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
