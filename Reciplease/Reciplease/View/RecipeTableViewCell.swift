//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 23/12/2020.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var yieldLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeBackroundStackView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func changeBackroundStackView() {
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 2
        recipeImageView.layer.shadowRadius = 10
        //            mettre ombrage sur phot
    }
    
    var recipe: Hit? {
        didSet {
            guard let recipe = recipe else { return }
            titleLabel.text = recipe.recipe.label
           recipeImageView.load(url: URL(string: recipe.recipe.image)!)
            timeLabel.text = String(recipe.recipe.totalTime)
            yieldLabel.text = String(recipe.recipe.yield)
            ingredientsLabel.text = recipe.recipe.ingredients[0].text

        
        }
    }
}

    extension UIImageView {
          func load(url:URL) {
              DispatchQueue.global().async { [weak self] in
                  if let data = try? Data(contentsOf: url) {
                      if let image = UIImage(data: data) {
                          DispatchQueue.main.async {
                              self?.image = image
                          }
                      }
                  }
              }
          }
    
}
