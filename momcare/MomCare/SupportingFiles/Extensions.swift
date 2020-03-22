//
//  Extensions.swift
//  MomCare
//
//  Created by Ebrahim  Mo Gedamy on 3/19/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//
import UIKit
import NVActivityIndicatorView
//import Reachability
//import SideMenu
//import Localize_Swift
//import Kingfisher
//import NotificationBannerSwift
//import EzPopup
//import SwiftEntryKit
//import SkyFloatingLabelTextField

class Extensions: NSObject {

}

extension UIImageView {
    
    func setImageWith(_ linkString: String?)  {
        guard let linkString = linkString,
            let url = URL(string: linkString) else { return }
      //  self.kf.setImage(with: url)
    }
    
    func setImageWith(url: URL?) {
        guard let url = url else { return  }
       // self.kf.setImage(with: url)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 1.0, y: 0.5)
        endPoint = CGPoint(x: 0.0, y: 0.5)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension UIButton {
    
    func setGradientBackgroundToButton(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: .normal)
    }
    
   /* func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle(), range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }*/
    
    func centerVertically(padding: CGFloat = 3.0) {
        
        guard
            let imageViewSize = self.imageView?.frame.size ,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height) + 10,
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
}

extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
  /*  override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }*/
    
    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }
        
        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        
        if let insets = padding {
            textWidth -= insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
        }
        
        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)
        
        contentSize.height = ceil(newSize.size.height) + insetsHeight
        
        return contentSize
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}

extension UIViewController : NVActivityIndicatorViewable {
    
    func showProgress(){
        NVActivityIndicatorView.DEFAULT_COLOR = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        NVActivityIndicatorView.DEFAULT_TYPE = NVActivityIndicatorType.ballPulseSync
        self.startAnimating()
    }
    
    func hideProgress(){
        self.stopAnimating()

    }
    
    
   // func errorMsg(text: SkyFloatingLabelTextField, msg: String, placeHolder: String){
        
    //    if text.text?.count == 0 {
    //        text.errorMessage = msg
     //       text.placeholder = ""
            
    //    }else{
      //      text.errorMessage = ""
    //        text.placeholder = placeHolder
            
      //  }
   // }
    
}

extension UIImageView {
    func setGradientBackgroundToImg(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        self.image = gradientLayer.createGradientImage()
    }
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "JFFlat-Regular", size: 16)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}



@IBDesignable class ThreeColorsGradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor(rgb: 0x157E71)
    @IBInspectable var secondColor: UIColor = UIColor(rgb: 0x15638C)
    
    @IBInspectable var vertical: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradient()
    }
    
    func applyGradient() {
        let colors = [firstColor.cgColor, secondColor.cgColor]
        
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        
        self.layer.addSublayer(layer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        #if TARGET_INTERFACE_BUILDER
        applyGradient()
        #endif
    }
}

extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = true
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}

extension UITextView {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
   
   /* override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in:  rect.inset(by: insets))
    }*/
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

extension UIViewController {
    
    
    //=================
    
    func textfeildError(txt : UITextField){
        if txt.text?.count != 0 {
            txt.layer.borderColor = UIColor.lightGray.cgColor
            
        }else{
            txt.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    
    //===========animation
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        //KeyboardAvoiding.avoidingView = view
        view.endEditing(true)
    }
    
    // present
   /* func presentDetails(viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }*/
    
    // dismiss
    /*func dismissDetails() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }*/
    
    
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    
    
   /* func convertToBase64(image : UIImage) -> String {
        
        let data : Data =  image.jpegData(compressionQuality: 0)!
        return data.base64EncodedString(options: .lineLength64Characters)
        
    }*/
    
   
    
   
//    func showCustomAlertForNetworkError(){
//        var alert = MIAlertController(
//
//            title: "No internet connection".localized(),
//            message: "you seem to be ofline, open WLAN or Use data".localized(),
//            buttons: [
//                MIAlertController.Button(title: "OK".localized(), action: {
//                })
//
//            ]
//
//            ).presentOn(self)
//
//    }
//
    //showAlert
    func showAlert(title: String, message:String, okAction: String , completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
        
        present(alert, animated: true, completion: nil)

      
        
        
    }
    
    //alert with cancel
   /* func showAlertWithCancel(title: String, message:String, okAction: String = "ok", completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
        if Language.currentLanguage() == "en"{
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel))
            present(alert, animated: true, completion: nil)
        }else{
            alert.addAction(UIAlertAction(title: "الغاء".localized(), style: .cancel))
            present(alert, animated: true, completion: nil)
        }
   
    }*/
    
    @objc func dismissview() {
        dismiss(animated: false, completion: nil)
    }
//
//    @objc func openMenu(view : UIViewController) {
//        let vc = Storyboard.Home.instantiate(ViewController.self)
//
//        self.present(vc, animated: true)
//    }
//
    
    @objc func openmenue (controller : UIViewController) {
        if(Language.currentLanguage() == "en"){
            
            
//            let sideMenuVc = Storyboard.Main.instantiate(MenuViewController.self)
//            sideMenuVc.controller = controller
//            let menuNavgtion = UISideMenuNavigationController(rootViewController: sideMenuVc)
//            SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
//            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:(self.navigationController?.navigationBar)! )
//            SideMenuManager.default.menuFadeStatusBar = false
//            SideMenuManager.default.menuWidth = ScreenWidth - 60
//            SideMenuManager.default.menuPresentMode = .viewSlideOut
//            SideMenuManager.default.menuLeftNavigationController = menuNavgtion
//            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
            
            
            
            
        }else{
            
            
//            let sideMenuVc = Storyboard.Main.instantiate(MenuViewController.self)
//            sideMenuVc.controller = controller
//            let menuNavgtion = UISideMenuNavigationController(rootViewController: sideMenuVc)
//            SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
//            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:(self.navigationController?.navigationBar)! )
//            SideMenuManager.default.menuFadeStatusBar = false
//            SideMenuManager.default.menuWidth = ScreenWidth - 60
//            SideMenuManager.default.menuPresentMode = .viewSlideOut
//            SideMenuManager.default.menuRightNavigationController = menuNavgtion
//            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
            
            
        }
        print("open menue")
        
        
        
        
    }
    
    
    
 
    
    @objc  func goback() {
        self.navigationController?.popViewController(animated: false)
    }
    @objc  func openChat() {
//        let vc =  Storyboard.Client.instantiate(ClientMessagesViewController.self)
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    func ButtonDesign(btn: UIButton, radius: CGFloat){
        btn.layer.cornerRadius = radius
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn.layer.shadowRadius = 15
        btn.layer.shadowOpacity = 1.0
        btn.clipsToBounds = true
    }
//
//    func viewSuccessMsg(title: String, body: String){
//        let view = MessageView.viewFromNib(layout: .tabView)
//        view.configureTheme(.success)
//        view.configureDropShadow()
//        view.configureContent(title: title, body: body)
//        view.button?.isHidden = true
//        view.button?.setTitle("OK".localized(), for: .normal)
//
//        SwiftMessages.show(view: view)
//
//
//    }
//
//    func viewErrorMsg(title: String, body: String){
//        let view = MessageView.viewFromNib(layout: .tabView)
//        view.configureTheme(.error)
//        view.configureDropShadow()
//        view.configureContent(title: title, body: body)
//        view.button?.setTitle("OK".localized(), for: .normal)
//
//        SwiftMessages.show(view: view)
//    }
   /* func viewSuccessMsgBanner(title: String, body: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "success"))
        let banner = NotificationCenter(title: title, subtitle: "  " + body, leftView: leftView, style: .success)
        banner.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 17)
        banner.subtitleLabel?.font = UIFont(name: "Cairo-Regular", size: 14)
        banner.show()
        
    }
    
    func viewErrorMsgBanner(title: String, body: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "danger"))
        let banner = NotificationBanner(title: title, subtitle: "  " + body , leftView: leftView, style: .danger)
        banner.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 17)
        banner.subtitleLabel?.font = UIFont(name: "Cairo-Regular", size: 14)
        banner.show()
    }
    func viewWarnningMsgBanner(title: String, body: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "info"))
        let banner = NotificationBanner(title: title, subtitle: "  " + body, leftView: leftView, style: .warning)
        banner.titleLabel?.font = UIFont(name: "Cairo-Bold", size: 17)
        banner.subtitleLabel?.font = UIFont(name: "Cairo-Regular", size: 14)
        banner.show()
    }
    
    
    func downloadImg(imgStr: String , image : UIImageView){
        image.kf.setImage(with: URL.init(string: imgStr),placeholder:nil,options:nil, progressBlock:nil ,completionHandler:nil )
    }
    
    //==============error aler
    func showErrorAlert(title : String , body : String){
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [.yellow, redColore], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: ScreenWidth), height: .intrinsic)
    
        
        let title = EKProperty.LabelContent(text: title, style: .init(font:UIFont(name: "Cairo-Regular", size: 16)!, color: UIColor.white))
        let description = EKProperty.LabelContent(text: body, style: .init(font: UIFont(name: "Cairo-SemiBold", size: 14)!, color: UIColor.white ))
        
        let image = EKProperty.ImageContent(image: UIImage(named: "danger")!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
        
    }*/
    
}

extension UIView {
    
    private static let kRotationAnimationKey = "rotationanimationkey"
        
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi/4 * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = 0
                
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
        
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }


    
   /* func downloadImg(imgStr: String , image : UIImageView){
        image.kf.setImage(with: URL.init(string: imgStr),placeholder:nil,options:nil, progressBlock:nil ,completionHandler:nil )
    }*/
    
    func dropShadow(scale: Bool = true) {
        self.layer.shadowColor = UIColor(rgb: 0xD4D4D4).cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
    }
    
    func cellshadow(){
        self.layer.applySketchShadow(color: UIColor.darkGray, alpha: 0.3, x: 0, y: 0, blur: 4, spread: 0)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
    func addDashedBorder() {
        let color = UIColor.gray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
      //  shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
  
}
//extension UITableViewCell {
//    @objc func downloadImg(imgStr: String , image : UIImageView){
//        image.kf.setImage(with: URL.init(string: imgStr),placeholder:nil,options:nil, progressBlock:nil ,completionHandler:nil )
//    }
//}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIView {
    // Using CAMediaTimingFunction
   /* func shake(duration: TimeInterval = 0.5, values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        //        // Swift 4.2 and above
        //        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        
        // Swift 4.1 and below
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        
        animation.duration = duration // You can set fix duration
        animation.values = values  // You can set fix values here also
        self.layer.add(animation, forKey: "shake")
    }*/
    // Using SpringWithDamping
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
    }
    // Using CABasicAnimation
    func shake(duration: TimeInterval = 0.05, shakeCount: Float = 6, xValue: CGFloat = 12, yValue: CGFloat = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = shakeCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
        self.layer.add(animation, forKey: "shake")
    }
}

