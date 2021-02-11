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
    
    
    var recipeDisplay: RecipeDisplay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteButtonAppearance()
    }
    
    private func updateFavoriteButtonAppearance() {
        guard coreDataManager?.checkIfRecipeIsAlreadyFavorite(recipeName: recipeDisplay?.label ?? "") == true else {
            favoriteButton.image = UIImage(systemName: "star")
            return }
        favoriteButton.image = UIImage(systemName: "star.fill")
    }
    
    
    
    
    private func updateView() {
        let defaultImage =  UIImage(named: "rectteDefault")
        
        recipeTitleLabel.text = recipeDisplay?.label
        
        guard let image = recipeDisplay?.image else { return }
        
        recipeImageView.image = UIImage(data: image) ?? defaultImage
        
        // importer image par default de asset
        totalTimeLabel.text = recipeDisplay?.time
        yieldLabel.text = recipeDisplay?.yield
        
    }
    
    private  func addRecipeToFavorite() {
        guard let name = recipeDisplay?.label, let image = recipeDisplay?.image, let yied = recipeDisplay?.yield, let totalTime = recipeDisplay?.time, let  ingredients = recipeDisplay?.ingredients, let url = recipeDisplay?.url else
        { return }
        
        coreDataManager?.createRecipe(name: name, image: image, yield: yied, totalTime: totalTime, ingredients: ingredients, url: url)
        
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let coreDataManager = coreDataManager else { return }
        guard let recipeName = recipeDisplay?.label else { return }
        // when recipe isn't in favorite list to add it, alert user
        if  !coreDataManager.checkIfRecipeIsAlreadyFavorite(recipeName:recipeName ) {
            sender.image = UIImage(systemName: "star.fill")
            addRecipeToFavorite()
            
        } else  {
            sender.image = UIImage(systemName: "star")
            coreDataManager.deleteFromFavorite(recipeName: recipeName )
            if tabBarController?.selectedIndex == 1 {
                navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
    
    
    @IBAction func directionButtonTapped(_ sender: Any) {
        
        guard let recipeDirections = URL(string: recipeDisplay?.url ?? "") else {return}
        UIApplication.shared.open(recipeDirections)
        
    }
    
}


extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDisplay?.ingredients.count ?? 00
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


