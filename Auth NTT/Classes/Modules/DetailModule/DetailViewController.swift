//
//  DetailViewController.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterDetailProtocol?
    
}

extension DetailViewController: PresenterToViewDetailProtocol{
    // TODO: Implement View Output Methods
}

class DetailNavigationController: UINavigationController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
