//
//  testTableViewCell.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 26/12/2020.
//

import UIKit

class testTableViewCell: UITableViewCell {

    @IBOutlet weak var imagecellll: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    var recipe: Hit? {
        didSet {
            guard let recipe = recipe else { return }
           
            imagecellll.loads(url: URL(string: recipe.recipe.image)!)
        }
    }
}

extension UIImageView {
    
      func loads(url:URL) {
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
