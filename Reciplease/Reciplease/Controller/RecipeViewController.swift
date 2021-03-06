//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 10/12/2020.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var recipes: Recipes?
    var recipeDisplay: RecipeDisplay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailRecipe" else { return }
        
        guard let recipesVc = segue.destination as? DetailViewController else {return}
        recipesVc.recipeDisplay = recipeDisplay
    }
}




extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // configure lines in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.hits.count ?? 0
    }
    
    // configure cell format with RecipeTableViewCell.xib
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else { return
            UITableViewCell() }
        cell.recipe = recipes?.hits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes?.hits[indexPath.row]
        
        guard let label = recipe?.recipe.label, let image = recipe?.recipe.image, let yield = recipe?.recipe.yield, let time = recipe?.recipe.totalTime.convertIntToTime, let ingredients = recipe?.recipe.ingredientLines , let url = recipe?.recipe.url else { return }
        
        let recipeDisplay = RecipeDisplay(label: label ,image: image.data , yield: String(yield) ,time: String(time), ingredients: ingredients, url: url )
        
        self.recipeDisplay = recipeDisplay
        
        performSegue(withIdentifier:"DetailRecipe", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}






