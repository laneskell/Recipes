//
//  DetailsRecipesViewController.swift
//  suduRecipes
//
//  Created by Kell Lanes on 28/06/21.
//

import Foundation
import UIKit

class DetailsRecipesViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var labelTitleRecipe: UILabel!
    @IBOutlet weak var labelDescriptionRecipe: UITextView!

    var recipe: Recipe!



    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitleRecipe.text = recipe.title
        labelDescriptionRecipe.text = recipe.description
        if let url = URL(string: recipe.image) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.recipeImageView.image = UIImage(data: data)
                }
            }

            task.resume()
        }
    }
}
