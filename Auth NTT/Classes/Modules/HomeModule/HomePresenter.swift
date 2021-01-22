//
//  HomePresenter.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import Foundation
import UIKit

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    var listBook: [Book] = []
    
    private var listBook_Default: [Book] = []
    
    func viewDidLoad() {
        
        view?.configRefreshControll()
        
        view?.setGreetings()
        
        view?.tapGestureInitial()
    }
    
    func onNavigateToDetail(navigationController: UINavigationController) {
        router?.navigateDetail(navigationConroller: navigationController)
    }
    
    func refresh() {
        
        interactor?.loadBooks()
    }
    
    func numberOfRowsInSection() -> Int {
        
        return listBook.count
    }
    
    func getBook(indexPath: IndexPath) -> Book {
        
        return listBook[indexPath.row]
    }
    
    func setBook(books: [Book]) {
        
        listBook = books
    }
    
    func resetBook() {
        listBook = listBook_Default
    }
    
    func getListDefaultBook() -> [Book] {
        
        return listBook_Default
    }
    
    func setObservableRx() {
        
        view?.subscriveSerach_Box()
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func requestBooskSuccess(data: [Book]) {
        
        self.listBook = data
        
        self.listBook_Default = data
        
        view?.onFetchBooksSuccess()
    }
    
    func requestBooksFailure(errorCode: Int) {
     
        AlertIOS(vc: view.self as! UIViewController, title: "Failed", message: "")
        
        view?.onFetchBooksFailure(error: errorCode)
    }
    
    func onLogoutSuccess() {
        
        view?.hideHUD()
        
        router?.backToLogin()
    }
    
    func onLogoutFailure(errorCode: Int) {
        
        AlertIOS(vc: view.self as! UIViewController, title: "Failed", message: "")
    }
}
