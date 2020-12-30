//
//  ViewController.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/12/2020.
//

import UIKit


class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var texField: UITextField!
    @IBOutlet weak var tableView: UITableView!  { didSet { tableView.tableFooterView = UIView() } }
    
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
        
        service.getData(q: ingredients.joined()) { result in
            switch result {
            case .success(let search):
                self.recipes = search
                self.performSegue(withIdentifier: "Result", sender: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func addRecipeButtonTaped(_ sender: Any) {
        
        guard let ingredient = texField.text else { return }
        ingredients.append(ingredient)
        tableView.reloadData()
        texField.text = ""
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    func changeTableView(){
        tableView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
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

extension SearchViewController: UITableViewDelegate {
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
}




