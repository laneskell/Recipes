//
//  RecipesListViewController.swift
//  suduRecipes
//
//  Created by Kell Lanes on 25/06/21.
//

import UIKit

class RecipesListViewController: UITableViewController {

    var arrayRecipes: [Recipe] = []
    
    @objc func refresh(sender:AnyObject)
    {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "idCellRecipe")
        APIService.getRecipeList(completion: {data,error,array in
            self.arrayRecipes = array
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "idCellRecipe", for: indexPath) as? CellRecipe{
            let recipe = arrayRecipes[indexPath.row]
            
            if recipe.category == "salgado" {
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor(red:  217/255.0, green: 241/255.0, blue: 255/255.0, alpha: 70.0/100.0)
                cell.backgroundView = bgColorView
            } else if recipe.category == "doce" {
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor(red:  255/255.0, green: 186/255.0, blue: 216/255.0, alpha: 60.0/100.0)
                cell.backgroundView = bgColorView
            } else{
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.gray
                cell.backgroundView = bgColorView
            }
            cell.labelTitle.text = recipe.title
            cell.labelTextDescription.text = recipe.description
            cell.labelCategory.text = recipe.category
            if let url = URL(string: recipe.image) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        cell.imageViewRecipe.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let recipeSelected = self.arrayRecipes[indexPath.row]
        
        
//COD PARA EXIBIR A TELA DE DETALHES - AJUSTAR
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "recipeDetailSegue" {
//
//         self.performSegue(withIdentifier: "recipeDetailSegue", sender: self)
//                if let destination = segue.destination as? DetailsRecipesViewController {
//
//                    destination.title = recipeSelected.title
//
//                    destination.labelTitleRecipe.text = recipeSelected.title
//                }
//            }
            
//        let mainStoryboard = UIStoryboard.init(name: "Custom", bundle: Bundle.main)
//        if let customViewController = mainStoryboard.instantiateViewController(identifier: "CustomViewControllerID") as? CustomViewController {
//        }
        
        let recipeVc = DetailsRecipesViewController()
        recipeVc.title =  recipeSelected.title
        
        self.navigationController?.pushViewController(recipeVc, animated: true)
            
//        self.present(UINavigationController(rootViewController: recipeVc), animated: true)
    }
    

}
