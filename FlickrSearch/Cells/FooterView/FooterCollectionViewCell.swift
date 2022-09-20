//
//  FooterCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import UIKit

class FooterCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    private func setup() {
        backgroundColor = .footerColor
        showSpinner()
    }
}
