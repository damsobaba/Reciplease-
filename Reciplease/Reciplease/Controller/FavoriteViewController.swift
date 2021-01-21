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
    
    
//    @IBAction func unindWelcomeSegue(segue: UIStoryboardSegue) {
//        segue.
//    }
//
    
    
    
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
        
        coreDataManager?.deleteAllIngredients()
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
    

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let favoriteRecipe = coreDataManager?.favoriteFood[indexPath.row]
        
   
        let recipeDisplay = RecipeDisplay(label: (favoriteRecipe!.name)!,image: (favoriteRecipe!.image)!, yield: (String((favoriteRecipe!.yield)!)) ,time: (String((favoriteRecipe?.totaTime)!)), ingredients: (favoriteRecipe?.ingredients)!, url: (favoriteRecipe?.url)!)
        
          self.recipeDisplay = recipeDisplay
        
        
          performSegue(withIdentifier: "FavoritesListToDetail", sender: nil)
      }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }

}
