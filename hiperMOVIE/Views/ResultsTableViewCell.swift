//
//  ResultCellTableViewCell.swift
//  hiperMOVIE
//
//  Created by Miguel Alejandro Correa Avila on 12/7/23.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var results: [Result] = []
    
    func configure(row:HomeRow){
        results = row.list.results
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension ResultsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(result: results[indexPath.row])
        return cell
    }

}

