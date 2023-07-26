//
//  CollectionViewCell.swift
//  hiperMOVIE
//
//  Created by Miguel Alejandro Correa Avila on 12/7/23.
//

import UIKit
import Kingfisher

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    

    func configure (result:Result) {
        title.text = result.title
        image.load(url:URL(string: Env.image_url+"/w500"+result.image) )
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

extension UIImageView {
    func load(url: URL?) {
        DispatchQueue.global().async { [weak self] in
            guard let url = url else {return}
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
