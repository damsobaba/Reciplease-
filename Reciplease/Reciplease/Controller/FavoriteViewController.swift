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
    var recipeDisplay: RecipeDisplay?
    
    
    
    
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "FavoritesListToDetail" else {return}
        guard let recipesVc = segue.destination as? DetailViewController else {return}
        recipesVc.recipeDisplay = recipeDisplay
    }
    
    
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
        coreDataManager?.deleteAllRecipe()
        favoriteTableView.reloadData()
        
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteFoods.count ?? 0
    } //c
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteRecipe = coreDataManager?.favoriteFoods[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRecipe = coreDataManager?.favoriteFoods[indexPath.row]
        
        guard let label = favoriteRecipe?.name, let image = favoriteRecipe?.image, let yield = favoriteRecipe?.yield, let time = favoriteRecipe?.totaTime, let ingredients = favoriteRecipe?.ingredients, let url = favoriteRecipe?.url else { return }
        
        let recipeDisplay = RecipeDisplay(label: label,image: image, yield: String(yield) ,time: String(time), ingredients: ingredients, url: url )
        self.recipeDisplay = recipeDisplay
        
        performSegue(withIdentifier: "FavoritesListToDetail", sender: nil)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some favorites in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
}
