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

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class RecipesListViewController: UITableViewController {

    var arrayRecipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "idCellRecipe")
        getRecipeList()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecipes.count
    }
    
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "idCellRecipe", for: indexPath) as? CellRecipe{
            let recipe = arrayRecipes[indexPath.row]
            
//            print(cell.btnTitle.titleLabel.text)
            
            cell.labelTitle.text = recipe.title
            
            return cell
        }
       
        
        return UITableViewCell()
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//       return 1
//    }

  
//
    func getRecipeList() {
        let url = URL (string: "http://localhost:3003/recipe")!
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let token:String = UserDefaults.standard.string(forKey: "token")!
//        print(token)
//        request.setValue(token, forHTTPHeaderField: "Authorization")

                
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
