//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 10/12/2020.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet var favoriteTableView: UITableView!
    
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
      
      
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        favoriteTableView.reloadData()
        }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteFood.count ?? 0
    } //c
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteRecipe = coreDataManager?.favoriteFood[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
//     asks data source to verify that the given row is editable
       func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
//        delete a favorite recipe in tableView
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           guard let recipeName = coreDataManager?.favoriteFood[indexPath.row].name else {return}
           coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeName)
           favoriteTableView.reloadData()
       }
}
