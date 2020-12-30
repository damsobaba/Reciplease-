//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 10/12/2020.
//

import UIKit

class FavoriteViewController: UITableViewController {

    private var coreDataManager: CoreDataManager?
          override func viewDidLoad() {
              super.viewDidLoad()
            
              guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              let coredataStack = appdelegate.coreDataStack
              coreDataManager = CoreDataManager(coreDataStack: coredataStack)
          }
  
}
