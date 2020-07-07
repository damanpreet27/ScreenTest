//
//  Overview_VC.swift
//  ScreenTest
//
//  Created by Digittrix  on 04/07/20.
//  Copyright © 2020 Digittrix . All rights reserved.
//

import UIKit


class Overview_VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{

    //MARK:- IBOutlet
    @IBOutlet weak var CVEventOrgniser: UICollectionView!
    
    
  
    //MARK:- View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

       
        
    }
   
    
   
    
//MARK:- Collection view delegate and datasource method
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   {
       return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = self.CVEventOrgniser.dequeueReusableCell(withReuseIdentifier: "CollectionCellEventOrgniser", for: indexPath) as! CollectionCellEventOrgniser
        
        return cell
    }
    
  
}
