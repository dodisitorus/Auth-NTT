//
//  DetailPresenter.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import Foundation

class DetailPresenter: ViewToPresenterDetailProtocol {

    // MARK: Properties
    var view: PresenterToViewDetailProtocol?
    var interactor: PresenterToInteractorDetailProtocol?
    var router: PresenterToRouterDetailProtocol?
}

extension DetailPresenter: InteractorToPresenterDetailProtocol {
    
}
