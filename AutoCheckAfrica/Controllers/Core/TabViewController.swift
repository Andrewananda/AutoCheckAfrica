//
//  TableViewController.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 24/07/2022.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomNavigation()
    }
    
    
    private func setupBottomNavigation() {
        
        let vc1 = HomeVC()

       
         vc1.navigationItem.largeTitleDisplayMode = .never
         
         let nav1 = UINavigationController(rootViewController: vc1)
         
         nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
         
         nav1.navigationBar.prefersLargeTitles = false

         setViewControllers([nav1], animated: false)
    }

}
