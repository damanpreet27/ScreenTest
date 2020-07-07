//
//  Home_VC.swift
//  ScreenTest
//
//  Created by Digittrix  on 04/07/20.
//  Copyright © 2020 Digittrix . All rights reserved.
//

import UIKit
import DMSegmentedPager
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView

class Home_VC: DMSegmentedPagerController
{
    //MARK:- IBOutlet
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var widthConstraintHeaderView: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeaderName: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    
    
    //MARK:- Requirements
    
   var items = ["Overview","Additional info","Contact","Comment"]
   var data = Dataholder()
    
    
    //MARK:- View did load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //api call
        getEventDetail()
         initialize()
    }
    
    
    //MARK:- Custom method
   func initialize()
   {
    
        segmentedPager.backgroundColor = #colorLiteral(red: 0.8248648047, green: 0.8346396089, blue: 0.8496133685, alpha: 1)
              
        // Parallax Header
        segmentedPager.parallaxHeader.view = headerView
        segmentedPager.parallaxHeader.mode = .fill
        segmentedPager.parallaxHeader.height = 420
        segmentedPager.parallaxHeader.minimumHeight = 80
              
        // Segmented Control customization
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = .white
        segmentedPager.segmentedControl.titleTextAttributes = [.foregroundColor : UIColor.darkGray]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [.foregroundColor : UIColor.black]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.2151061296, green: 0.7141426206, blue: 0.9525232911, alpha: 1)
   
        
       
}
 
    //MARK:- Method for segmented pager
   func heightForSegmentedControlInSegmentedPager(_ segmentedPager: DMSegmentedPager) -> CGFloat
   {
       return 60
   }
          
    func segmentedPager(_ segmentedPager: DMSegmentedPager, didSelectPageWith title: String)
    {
        print("\(title) page selected.")
    }
          
    override func numberOfPages(in segmentedPager: DMSegmentedPager) -> Int
    {
        return items.count
    }
          
    func segmentedPager(_ segmentedPager: DMSegmentedPager, titleForSectionAt index: Int) -> String
    {
        return items[index]
    }
          
    override func segmentedPager(_ segmentedPager: DMSegmentedPager, viewForPageAt index: Int) -> UIView
    {
        switch index
        {
                  default: return super.segmentedPager(segmentedPager, viewForPageAt: index)
        }
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
          
    //MARK:- Web Services
    func getEventDetail()
    {
       self.objHudShow()
                      
        let params =
                    [
                        "latitude" : "28.1245",
                        "longitude" : "78.1245",
                        "event_id" : "12",
                        "user_id" : "00"
                                        
                    ]
                    print(params)
                        
                    Alamofire.request("http://saudicalendar.com/api/user/getEventDetail", method: .post, parameters: params, encoding: URLEncoding.default).responseJSON{ response in
                             
                    self.objHudHide()
                    switch response.result
                    {
                            case .success (let data):
                            print(data)
                                 
                                 let json = JSON(response.result.value!);
                                 print(json["error"])
                                 
                                 if json["error"] == false
                                 {
                                     let jsonObject = response.result.value
                                     let jsonDict : Dictionary = jsonObject as! Dictionary<String,Any>
                                       
                                     if let dataTempDict : Dictionary = jsonDict["data"] as? Dictionary<String,Any>
                                     {
                                        self.data.dataDict = dataTempDict
                                        print(self.data.dataDict!)
                                        if let ev_image : NSArray = dataTempDict["ev_image"] as? NSArray
                                        {
                                            if let imageDict: Dictionary = ev_image[0] as? Dictionary<String,Any>
                                            {
                                                if let image : String = imageDict["image"] as? String
                                                {
                                                    self.headerImage.sd_setShowActivityIndicatorView(true)
                                                    self.headerImage.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
                                                    
                                                    let urlNew : String = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                                    let url = URL(string: urlNew)
                                                    self.headerImage.sd_setImage(with: url, placeholderImage:nil)
                                                }
                                            }
                                        }
                                       
                                        if let event_organizer : NSArray = (self.data.dataDict!["event_organizer"] as? NSArray)?.mutableCopy() as? NSMutableArray
                                        {
                                            print(event_organizer)
                                            self.data.arrayOrgniser = event_organizer as? NSMutableArray
                                            
                                        }
                                        
                                     }
                                    
                                    self.segmentedPager.pager.reloadData()
                                    self.reloadInputViews()
                                   
                                 }
                                 else
                                 {
                                   //self.view!.makeToast(json["status"].rawString(), duration: 2, position: .bottom)
                                 }
                                 
                                 break
                                 
                             case .failure:
                                 
                                
                                 let alertViewController = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Something went wrong please try again", comment: "") , preferredStyle: .alert)
                                 let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) -> Void in
                                     
                                 }
                                 alertViewController.addAction(okAction)
                                 self.present(alertViewController, animated: true, completion: nil)
                                 
                                 break
                             }
                         }
                     }
}
