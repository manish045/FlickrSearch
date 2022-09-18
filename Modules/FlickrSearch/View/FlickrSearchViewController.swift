//
//  FlickrSearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

class FlickrSearchViewController: UIViewController, FlickrSearchViewInput {
   
    var presenter: FlickrSearchViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setUpNavigation() {
        title = AppConstant.Strings.flickrSearchTitle
    }
}
