//
//  UIView+Extention.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import UIKit

extension UIView {
    /// Configure ActivityView Indicator
    func showSpinner() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = UIColor.activityIndicatorColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func hideSpinner() {
        guard let spinner = self.subviews.last as? UIActivityIndicatorView else { return }
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}
