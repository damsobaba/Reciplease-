//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 30/12/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var goDirectionButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientDetailTableView: UITableView!
    
    
    private var coreDataManager: CoreDataManager?
    
    var recipe: Recipe?
    
    var recipeDisplay: RecipeDisplay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        updatView()
    }
    
    
    ///enable to show activiy controler while loading
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        
    }
    
    func updatView() {
        recipeTitleLabel.text = recipeDisplay?.label
        recipeImageView.image = UIImage(data: recipeDisplay?.image ?? Data())
        totalTimeLabel.text = recipeDisplay?.time
        yieldLabel.text = recipeDisplay?.yield
        
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: UIBarButtonItem) {
        
        // mettre la methode qui check si la recette est en favorie
        if sender.image == UIImage(systemName: "star") {
            sender.image = UIImage(systemName: "star.fill")
        } else if
            sender.image == UIImage(systemName: "star.fill") {
            sender.image = UIImage(systemName: "star")
        }
        
        guard let name = recipeDisplay?.label, let image = recipeDisplay?.image, let yied = recipeDisplay?.yield, let totalTime = recipeDisplay?.time, let  ingredients = recipeDisplay?.ingredients, let url = recipeDisplay?.url else
        { return }
        
        coreDataManager?.createIngredients(name: name, image: image, yield: yied, totalTime: totalTime, ingredients: ingredients, url: url)
        
    }
    
    @IBAction func directionButtonTapped(_ sender: Any) {
    
        guard let recipeDirections = URL(string: recipeDisplay?.url ?? "") else {return}
        UIApplication.shared.open(recipeDirections)
    
    }
    
}


extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipeDisplay?.ingredients.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeDisplay = recipeDisplay else { return UITableViewCell() }
        
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsDetailCell", for: indexPath)
        let ingredient = recipeDisplay.ingredients[indexPath.row]
        ingredientCell.textLabel?.textColor = UIColor.white
        ingredientCell.textLabel?.text = "- \(ingredient)"
        
        return ingredientCell
    }
}




