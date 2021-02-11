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
        changeBackroundStackView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func changeBackroundStackView() {
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 2
        recipeImageView.layer.shadowRadius = 40
        recipeImageView.layer.shadowOpacity = 40
        
    }
  
    
    var recipe: Hit? {
        didSet {
            guard let recipe = recipe else { return }
            
            titleLabel.text = recipe.recipe.label
            
            guard let image = recipe.recipe.image else {return}
            guard let url = URL(string: image) else {return}
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url)
                            DispatchQueue.main.async {
                                self.recipeImageView.image = UIImage(data: data! as Data)
                            }
                        }
            timeLabel.text = recipe.recipe.totalTime.convertIntToTime 
            yieldLabel.text = String(recipe.recipe.yield)
            ingredientsLabel.text = recipe.recipe.ingredients[0].text


        }
    }

    
    var favoriteRecipe: FavoriteFood? {
        didSet {
            titleLabel.text = favoriteRecipe?.name
     
            timeLabel.text = favoriteRecipe?.totaTime
            yieldLabel.text = favoriteRecipe?.yield
            ingredientsLabel.text = favoriteRecipe?.ingredients!.joined()
            recipeImageView.image = UIImage(data:  favoriteRecipe?.image ?? Data())

            
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


extension Int {
    
    /// Convert Int to time in String
    var convertIntToTime: String {
        if self == 0 {
            let timeNull = "--"
            return timeNull
        } else {
            let minutes = self % 60
            let hours = self / 60
            let timeFormatString = String(format: "%01dh%02d", hours, minutes)
            let timeFormatStringMin = String(format: "%02dm", minutes)
            let timeFormatNoMin = String(format: "%01dh", hours)
            let timeFormatStringLessTenMin = String(format: "%01dm", minutes)
            if self < 60 {
                if minutes < 10 {
                return timeFormatStringLessTenMin
                }
                return timeFormatStringMin
            } else if minutes == 0 {
                return timeFormatNoMin
            } else {
                return timeFormatString
            }
        }
    }
}



