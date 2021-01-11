//
//  Extansions.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/01/2021.
//

import UIKit

extension UIViewController {
    ///present allert
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "you need signal for the application to work", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    func presentAlertWrongIngredients() {
        let alertVC = UIAlertController(title: "Error", message: "Please enter a ingredient", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
