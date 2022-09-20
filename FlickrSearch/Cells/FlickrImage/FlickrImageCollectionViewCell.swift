//
//  FlickrImageCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

class FlickrImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model: FlickrPhoto! {
        didSet {
            self.photoImageView.downloadImage(from: model.url)
        }
    }
}
