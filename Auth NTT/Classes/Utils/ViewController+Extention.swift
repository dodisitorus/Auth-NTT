//
//  ViewController.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class CardView: UIView {

    @IBInspectable var Shadow: Bool = true {
        didSet {
            self.layer.shadowRadius = 3;
            self.layer.shadowOpacity = 0.3;
            self.layer.shadowOffset = CGSize(width: 1, height: 1);
            
            let shadowColor: CGColor = UIColor(white: 0.33333333329999998, alpha: 1).cgColor
            
            self.layer.cornerRadius = 10;
            
            self.layer.shadowColor = shadowColor
            
        }
    }
}

class BookCardView: UIView {
    
    @IBInspectable var Shadow: Bool = true {
        didSet {
            self.layer.shadowRadius = 4;
            self.layer.shadowOpacity = 0.5;
            self.layer.shadowOffset = CGSize(width: 0, height: 3);
            
            let shadowColor: CGColor = UIColor(white: 0.33333333329999998, alpha: 0.4).cgColor
            
            self.layer.cornerRadius = 25;
            
            self.layer.shadowColor = shadowColor
            
        }
    }
}

class SearchCardView: UIView {
    
    @IBInspectable var Shadow: Bool = true {
        didSet {
            self.layer.shadowRadius = 2;
            self.layer.shadowOpacity = 0.4;
            self.layer.shadowOffset = CGSize(width: 0, height: 1);
            
            let shadowColor: CGColor = UIColor(white: 0.33333333329999998, alpha: 0.4).cgColor
            
            self.layer.cornerRadius = 25;
            
            self.layer.shadowColor = shadowColor
            
        }
    }
}

class CircleCardView: UIView {

    @IBInspectable var Show: Bool = true {
        didSet {
            self.layer.shadowRadius = 3;
            self.layer.shadowOpacity = 0.3;
            self.layer.shadowOffset = CGSize(width: 0, height: 1);
            
            let shadowColor: CGColor = UIColor(white: 0.33333333329999998, alpha: 0.8).cgColor
            
            self.layer.cornerRadius = 10;
            
            self.layer.shadowColor = shadowColor
            
            self.layer.cornerRadius = self.bounds.width / 2;
            self.layer.cornerRadius = self.bounds.width / 2;
        }
    }
}

class ShimmerView: UIView {
    
    var stats: Bool = false
    
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable var Animate: Bool = true {
        didSet {
            self.stats = Animate
            startAnimating()
        }
    }
    
    @IBInspectable var Circle: Bool = true {
        didSet {
            if (Circle) {
                gradientLayer.cornerRadius = self.bounds.width / 2;
                gradientLayer.cornerRadius = self.bounds.width / 2;
            }
        }
    }
    
    var gradientColorOne : CGColor = UIColor(displayP3Red: 0.92143100499999997, green: 0.92145264149999995, blue: 0.92144101860000005, alpha: 0.7).cgColor
    
    var gradientColorTwo : CGColor = UIColor(displayP3Red: 0.83741801979999997, green: 0.83743780850000005, blue: 0.83742713930000001, alpha: 0.6).cgColor
    
    func getGradientLayer() -> CAGradientLayer {
        
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        self.layer.addSublayer(gradientLayer)
        
        return gradientLayer
    }
    
    func getAnimation() -> CABasicAnimation {
       
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.2
        return animation
    }
    
    func startAnimating() {
        
        let gradientLayer = getGradientLayer()
        
        let animation = getAnimation()
        
        if (stats) {
            gradientLayer.add(animation, forKey: animation.keyPath)
        }
    }
}

public func setOpacityTapGesture(VC: UIViewController, InitialView: UIView, time: DispatchTime = .now() + 1, beganAlpha: CGFloat = 0.2) {
    // set respone on uiview when touched
    let firstOpacity = InitialView.alpha
    let firstShadowO = InitialView.shadowOffset
    
    InitialView.alpha = beganAlpha
    InitialView.shadowOffset = CGSize(width: 0, height: 0)
    DispatchQueue.main.asyncAfter(deadline: time) {
        // Code you want to be delayed
        InitialView.alpha = firstOpacity
        InitialView.shadowOffset = firstShadowO
    }
}

func AlertIOS(vc: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: NSLocalizedString("oke", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
        //Cancel Action
    }))
    
    vc.present(alert, animated: true, completion: nil)
}

public func calculateSizeOf(text: String, view: UIView, spacing: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight, fontName: String) -> CGRect {
    let approximateidthOfLabel = view.frame.width - spacing
    let size = CGSize(width: approximateidthOfLabel, height: 1000)
    
    let font = UIFont(name: fontName, size: fontSize)
    let fontAttributes = [NSAttributedString.Key.font: font]
    _ = (text as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
    let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: fontAttributes as [NSAttributedString.Key : Any], context: nil)
    
    return estimatedFrame
}

extension UIView {

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue
        }
    }
}

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

protocol XIBLocalizable {
    var LanguageStringKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var LanguageStringKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var LanguageStringKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var LanguageStringKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}

extension UITabBarItem: XIBLocalizable {
    @IBInspectable var LanguageStringKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}

extension UINavigationItem: XIBLocalizable {
    @IBInspectable var LanguageStringKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}


