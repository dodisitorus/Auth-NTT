//
//  HomeViewController.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import UIKit
import PKHUD
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var LoadingView: UIView!
    
    @IBOutlet weak var CollectionView_Book: UICollectionView!
    @IBOutlet weak var heightConstraint_CollectionView_Book: NSLayoutConstraint!
    
    @IBOutlet weak var label_GreetUser: UILabel!
    @IBOutlet weak var label_GreetingMore: UILabel!
    
    @IBOutlet weak var BtnView_Add: CircleCardView!
    
    @IBOutlet weak var TF_SearchBook: UITextField!
    
    private let refreshControll = UIRefreshControl()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LoadingView.isHidden = false
        
        self.scrollView.isHidden = true
        
        presenter?.viewDidLoad()
        
        presenter?.setObservableRx()
        
        self.presenter?.interactor?.loadBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    
    @objc func refreshControllScrollView() {

        self.refreshControll.beginRefreshing()
        
        self.presenter?.refresh()
    }
    
    @IBAction func onLogOut(_ sender: Any) {
     
        self.onConfirmLogout {
            
            self.showHUD()
            
            self.presenter?.interactor?.logout()
        }
    }
}

extension HomeViewController: PresenterToViewHomeProtocol {
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func onFetchBooksSuccess() {
     
        self.scrollView.isHidden = false
        
        self.CollectionView_Book.reloadData()
        
        self.refreshControll.endRefreshing()
        
        self.LoadingView.isHidden = true
    }
    
    func onFetchBooksFailure(error: Int) {
        
        
        self.refreshControll.endRefreshing()
        
        self.LoadingView.isHidden = true
    }
    
    func configRefreshControll() {
        
        // refresh controll
        refreshControll.addTarget(self, action: #selector(self.refreshControllScrollView), for: .valueChanged)
        refreshControll.attributedTitle = NSAttributedString(string: "Loading data...")
        
        self.scrollView.refreshControl = refreshControll
    }
    
    func setGreetings() {
        
        // set greeting name user
        LocalStore.get(key: keyStores.fullname) { (name) in
            self.label_GreetUser.text = "Hai \(name),"
            self.label_GreetingMore.attributedText = NSAttributedString(string: "\(NSLocalizedString("greetingMainScreen", comment: "")) 🙂")
        }
    }
    
    func tapGestureInitial()  {
        // set tap gesture on View
        view.addGestureRecognizer(setTapGesture())
    }
    
    func setTapGesture() -> UITapGestureRecognizer {
        // ui tap gesture
        var tapRecognizer = UITapGestureRecognizer()
        // set selector action for gesture
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectorTapGesture(sender:)))
        // return gesture
        return tapRecognizer
    }
    
    @objc func selectorTapGesture(sender: UITapGestureRecognizer) {
        switch sender.view {
        case self.view:
            view.endEditing(true)
        default:
            print("none")
        }
    }
    
    func onConfirmLogout(completion: @escaping() -> ()) {
        
        let alert = UIAlertController(title: "Sign Out", message: NSLocalizedString("warningLogout", comment: ""), preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.destructive, handler: { _ in
            //Cancel Action
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            
            completion()
            
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func subscriveSerach_Box() {
        
        self.TF_SearchBook.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                
                self.autoComplete(key: self.TF_SearchBook.text ?? "")
                
                print(self.TF_SearchBook.text ?? "")
                
            }).disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return presenter?.numberOfRowsInSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as! BooksCell
        
        cell.name.text = presenter?.getBook(indexPath: indexPath).name
        
        cell.btnDetail.tag = indexPath.row
        
        let height = self.CollectionView_Book.contentSize.height
        self.heightConstraint_CollectionView_Book.constant = height
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let name: String = "\(presenter?.getBook(indexPath: indexPath).name ?? "-")"
        let height = calculateSizeOf(text: name, view: self.view, spacing: 91, fontSize: 19, fontWeight: .medium, fontName: "AvenirNext-Medium").height
        
        return CGSize(width: self.view.frame.width, height: 42 + height)
    }
    
    func autoComplete(key: String) {
        if key == "" {
            presenter?.resetBook()
            
            self.CollectionView_Book.reloadData()
        } else {
            
            let listDefaultBoook: [Book] = presenter?.getListDefaultBook() ?? []
            
            let filtered: [Book] = listDefaultBoook.filter { (book) -> Bool in
                book.name.lowercased().contains(key.lowercased())
            }
            
            presenter?.setBook(books: filtered)
            
            self.CollectionView_Book.reloadData()
        }
    }
}

class HomeNavigationController: UINavigationController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class BooksCell: UICollectionViewCell {
    
    @IBOutlet weak var parentView: BookCardView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var btnDetail: UIButton!
    
}
