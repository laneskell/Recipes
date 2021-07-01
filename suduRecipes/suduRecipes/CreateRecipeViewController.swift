//
//  createRecipeView.swift
//  suduRecipes
//
//  Created by Kell Lanes on 29/06/21.
//

import UIKit

class CreateRecipeViewController: UIViewController {
    
    @IBOutlet weak var textFieldTitleCreateRecipe: UITextField!
    @IBOutlet weak var textFieldUrlCreateRecipe: UITextField!
    @IBOutlet weak var textFieldDescriptionCreateRecipe: UITextField!
    
    @IBOutlet weak var textFieldCategory: UITextField!
    
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func alertConfirm(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonCreateNewRecipe(_ sender: Any) {
        
        let title = textFieldTitleCreateRecipe.text ?? ""
        let url = textFieldUrlCreateRecipe.text ?? ""
        let category = textFieldCategory.text ?? ""
        let description = textFieldDescriptionCreateRecipe.text ?? ""
        
        if title != "" && description != "" {
            
            
            APIService.createRecipe(title: title, url: url, category: category, description: description, completion: { responseData, error in
                
                
                 if error == nil {
                                    self.alertConfirm(title: "Concluído", message: "Receita criada com sucesso!")
                                    }
                                })
       
        } else {
        self.alertMessage(title: "Dados incompletos", message: "Título e Descrição são requeridos!")
    }
        self.dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
