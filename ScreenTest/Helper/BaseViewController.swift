//
//  BaseViewController.swift
//  Frupal
//
//  Created by Digittrix-3 on 21/08/19.
//  Copyright © 2019 Digittrix. All rights reserved.
//

import UIKit
import SystemConfiguration
import NVActivityIndicatorView


class BaseViewController: UIViewController {
    
    
    static let API_URL = "http://saudicalendar.com/api/user/getEventDetail"
   
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    //MARK:- Alert
    
    func alertView (_ title: String = "Alert" , message: String , controller: UIViewController){
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        controller.present(alert, animated: true)
    }
    
    
   
    
    //MARK:- Acticity Indicator
    
    var objNVHud = ActivityData(size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE, message: nil, messageFont: nil, type: NVActivityIndicatorType.ballRotateChase, color: #colorLiteral(red: 0.3568627451, green: 0.3843137255, blue: 0.6156862745, alpha: 1) , padding: nil, displayTimeThreshold: NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD, minimumDisplayTime: NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME)
    
    
    func objHudShow()
    {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(objNVHud,nil)
    }
    
    
    func objHudHide()
    {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    
   
    
    
}
