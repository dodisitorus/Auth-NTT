//
//  LoginViewController.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//  
//

import UIKit
import PKHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var TF_Email: UITextField!
    @IBOutlet weak var TF_Password: UITextField!
    
    @IBOutlet weak var BtnView_Login_Email: BookCardView!
    @IBOutlet weak var btnEyePassword: UIButton!
    
    private var notificationName: String = "BackHandlerHome"
    
    private var statePassword: Bool = false
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Properties
    var presenter: ViewToPresenterLoginProtocol?
    
    @IBAction func onLogin(_ sender: Any) {
        
        presenter?.loginEmail(self.TF_Email.text ?? "", password: self.TF_Password.text ?? "")
    }
    
    @IBAction func onChangeStatePassword(_ sender: Any) {
        
        self.TF_Password.isSecureTextEntry = self.statePassword
        
        if self.statePassword == false {
            
            self.btnEyePassword.setImage(UIImage(named: "show-password"), for: .normal)
            
        } else {
            self.btnEyePassword.setImage(UIImage(named: "hide-password"), for: .normal)
        }
        
        self.statePassword = !self.statePassword
    }
    
}

extension LoginViewController: PresenterToViewLoginProtocol {
    
    func onRequestLoginSuccess() {
        
        
    }
    
    func onRequestLoginFailure(error: String) {
        AlertIOS(vc: self, title: "Failed", message: "Please Try Again")
    }
    
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
}

class LoginNavigationController: UINavigationController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
