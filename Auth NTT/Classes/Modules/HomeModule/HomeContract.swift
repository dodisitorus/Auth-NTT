//
//  HomeContract.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol {
    
    func onFetchBooksSuccess()
    func onFetchBooksFailure(error: Int)
    
    func configRefreshControll()
    
    func setGreetings()
    
    func tapGestureInitial()
    
    func showHUD()
    func hideHUD()
    
    func subscriveSerach_Box()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    
    func viewDidLoad()
    
    func onNavigateToDetail(navigationController: UINavigationController)
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    
    func getBook(indexPath: IndexPath) -> Book
    
    func setBook(books: [Book])
    
    func resetBook()
    
    func getListDefaultBook() -> [Book]
    
    func setObservableRx()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    
    func loadBooks()
    
    func logout()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol {
    
    func requestBooskSuccess(data: [Book])
    func requestBooksFailure(errorCode: Int)
    
    func onLogoutSuccess()
    func onLogoutFailure(errorCode: Int)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol {
    
    func navigateDetail(navigationConroller:UINavigationController)
    
    func backToLogin()
}
