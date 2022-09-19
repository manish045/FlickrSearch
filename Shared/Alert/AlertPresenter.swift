//
//  AlertPresenter.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import UIKit


protocol AlertsPresenting: UIViewController {
    
}

extension AlertsPresenting {
    func showAlert(title: String, message: String, retryAction: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if retryAction != nil {
            alertViewController.addAction(UIAlertAction(title: AppConstant.Strings.cancel, style: .default))
        }
        let title = (retryAction == nil) ? AppConstant.Strings.ok : AppConstant.Strings.retry
        alertViewController.addAction(UIAlertAction(title: title, style: .default) { _ in
            retryAction?()
        })
        present(alertViewController, animated: true)
    }
}
