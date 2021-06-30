//
//  RecipesListViewController.swift
//  suduRecipes
//
//  Created by Kell Lanes on 25/06/21.
//

import UIKit

struct Recipe: Codable {
    let id: String
    let image: String
    let title: String
    let description: String
    let created_at: String
    let author_id: String

}


class RecipesListViewController: UITableViewController {


    
    var arrayRecipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "idCellRecipe")
        getRecipeList()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipes.count
    }
    
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "idCellRecipe", for: indexPath) as? CellRecipe{
            let recipe = arrayRecipes[indexPath.row]
            cell.labelTitle.text = recipe.title
            cell.labelTextDescription.text = recipe.description
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
            
        
        
        let recipeVc = UIViewController()
    recipeVc.title =  recipeSelected.title
    
        self.present(UINavigationController(rootViewController: recipeVc), animated: true, completion: nil)
        
        
       
    }

    
    
    func getRecipeList() {
        let url = URL (string: "http://localhost:3003/recipe")!
                
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            print("response: \(String(describing: response))")
            print("error de req: \(String(describing: error))")

            if let data = data{
                do {
                    self.arrayRecipes =  try JSONDecoder().decode([Recipe].self, from: data)
                    print("receitas:", self.arrayRecipes)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                  
                    
                }catch let error {
                    print("deu errado:",error)
                }
                
            }
        
        }

        
        task.resume()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
