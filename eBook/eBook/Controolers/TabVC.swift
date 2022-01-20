//
//  TabVC.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit
import FirebaseAuth


class TabVC: UITabBarController {
    
    
   
    fileprivate func createNavController(for rootViewController: UIViewController,
                         title: String,
                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.accessibilityTextualContext = .console
        navController.navigationBar.prefersLargeTitles = false

        return navController
      }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
            //   rgba(229,214,197,255)
        tabBar.backgroundColor = UIColor(named: "textColor")
        tabBar.layer.cornerRadius = 15
        tabBar.barTintColor = .white
        tabBar.layer.masksToBounds = true
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    
        
        
        
        viewControllers = [
            createNavController(for: HomeVC() , title: NSLocalizedString("home", comment: ""),image: UIImage(systemName: "book")!),
             
//            createNavController(for: ChildsBooks() , title: NSLocalizedString("child", comment: ""),image: UIImage(systemName: "magazine")!),
//
            createNavController(for: FavouriteVC(), title: NSLocalizedString("favourite", comment: ""),image: UIImage(systemName: "suit.heart.fill")!),
             
            createNavController(for: ProfileVC(), title: NSLocalizedString("profile", comment: ""),image: UIImage(systemName: "person.fill.viewfinder")!),
            
    
     
           
        ]
    }
}


