//
//  ViewController.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/12/2020.
//

import UIKit


class SearchViewController: UIViewController, UITextFieldDelegate{
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!  { didSet { tableView.tableFooterView = UIView() } }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var recipes: Recipes?
    private var ingredients:[String] = []
    private let service: RequestService = RequestService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTableView()
    }
    
    //MARK: - Configure segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipesVC = segue.destination as? RecipeViewController {
            recipesVC.recipes = recipes
        }
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        service.getData(q: ingredients.joined(separator: ",")) { result in
            switch result {
            case .success(let search):
                self.toggleActivityIndicator(shown: false)
                self.recipes = search
                self.performSegue(withIdentifier: "Result", sender: nil)
            case .failure(let error):
                error == .noData ? self.presentAlertSignal() : self.presentAlertWrongIngredientsEnter()
                self.toggleActivityIndicator(shown: false)
                print(error)
            }
        }
    }
    
    
    
    //MARK: - Methods
    
    // Method to dissmiss keyboard when user tap on "done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    private func changeTableView(){
        tableView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    ///enable to show activiy controler while loading
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchRecipeButton.isHidden = shown
    }
    
    //MARK: - Actions
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @IBAction func addRecipeButtonTaped(_ sender: Any) {
        
        guard let ingredient = textField.text , !ingredient.isBlank else {
            presentAlertWrongIngredients()
            return }
        ingredients.append(ingredient)
        tableView.reloadData()
        textField.text = ""
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        ingredients.removeAll()
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath)
        ingredientCell.textLabel?.text = "- "+ingredients[indexPath.row]
        ingredientCell.textLabel?.textColor = UIColor.white
        return ingredientCell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some ingredients in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty ? 200 : 0
    }
    
    // delete a row in tableView
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

