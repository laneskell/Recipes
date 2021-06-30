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
    
    func alertMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func alertConfirm(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonCreateNewRecipe(_ sender: Any) {
        
        let title = textFieldTitleCreateRecipe.text ?? ""
        let urlText = textFieldUrlCreateRecipe.text ?? ""
        let description = textFieldDescriptionCreateRecipe.text ?? ""
        
        if title != "" && description != ""{
            
            createRecipe(title: title, urlText: urlText, description: description)
            
        }else {
            self.alertMessage(title: "Dados incompletos", message: "Título e Descrição são requeridos!")
        }
    }
    
    func createRecipe(title:String, urlText:String, description:String) {
        let url_base = URL (string: "http://localhost:3003/recipe")!
        var request = URLRequest(url: url_base)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "title": title,
            "url": urlText,
            "description": description
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
       
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")

            guard data != nil else {return}
        
            do {
                
                self.alertConfirm(title: "Concluído", message: "Receita criada com sucesso!")
                
            }
            
            
        }

        
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
