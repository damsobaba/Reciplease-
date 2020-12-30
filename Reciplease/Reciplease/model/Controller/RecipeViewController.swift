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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailRecipe" else {
            return
        }
     
   
    
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
        performSegue(withIdentifier:"DetailRecipe", sender: nil)
    }
}




 

