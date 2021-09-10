//
//  ViewController.swift
//  moviesAPP
//
//  Created by NOELIA ZARZOSO on 09/09/2021.
//

import UIKit

class ViewController: UITabBarController {
    var popularVC: PopularFilmsViewController!
    var favVC: FavFilmsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        popularVC = self.viewControllers![0] as? PopularFilmsViewController
        favVC = self.viewControllers![1] as? FavFilmsViewController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        popularVC.tableView?.reloadData()
        favVC.favFilmsArray = popularVC.favFilmsArray
        favVC.tableView?.reloadData()
    }


}

