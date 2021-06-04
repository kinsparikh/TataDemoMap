//
//  UIViewControllerExtension.swift
//  TataMapDemo
//
//  Created by Kayaan Parikh on 03/06/20.
//  Copyright © 2021 Kayaan Parikh. All rights reserved.
//

import UIKit
import SwiftMessages


extension UIViewController{
    
    func commonErrorMessage(errorTitle : String, body : String, position : String? = ""){
        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(.error, iconStyle: .light)
        error.configureContent(title: errorTitle, body: body)
        error.configureDropShadow()
        var errorConfig = SwiftMessages.defaultConfig
        errorConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        if(position == "Centre"){
            errorConfig.presentationStyle = .center
        }else if (position == "Bottom"){
            errorConfig.presentationStyle = .bottom
        }else{
            errorConfig.presentationStyle = .top
        }
        error.button?.isHidden = true
        SwiftMessages.show(config: errorConfig,view: error)
    }
    
    func commonSucessMessage(successTitle : String, body : String, position : String? = ""){
        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(.success, iconStyle: .light)
        error.configureContent(title: successTitle, body: body)
        error.configureDropShadow()
        var errorConfig = SwiftMessages.defaultConfig
        errorConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        if(position == "Centre"){
            errorConfig.presentationStyle = .center
        }else if (position == "Bottom"){
            errorConfig.presentationStyle = .bottom
        }else{
            errorConfig.presentationStyle = .top
        }
        
        error.button?.isHidden = true
        SwiftMessages.show(config: errorConfig,view: error)
    }
    
    func commonInforMessage(successTitle : String, body : String){
        let info = MessageView.viewFromNib(layout: .tabView)
        info.configureTheme(.info)
        info.backgroundView.backgroundColor = UIColor.white.withAlphaComponent(1.2)
        info.button?.isHidden = true
        info.iconImageView?.image = #imageLiteral(resourceName: "PinMarker")
        info.configureContent(title: successTitle, body: body)
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationStyle = .top
        infoConfig.duration = .seconds(seconds: 5.0)
        SwiftMessages.show(config: infoConfig, view: info)
    }

}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}


extension UIView {
    
    func makeCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height + 10, width:self.frame.size.width + 20, height:width)
        self.layer.addSublayer(border)
    }

    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addMiddleBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:self.frame.size.width/2, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func setCardView(){
        layer.masksToBounds = false
        layer.cornerRadius = 8.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.2
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:2, height: 2)
    }
    
    func roundedCorners(corners : UIRectCorner, radius : CGFloat) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
}




