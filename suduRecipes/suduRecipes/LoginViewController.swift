//
//  LoginViewController.swift
//  suduRecipes
//
//  Created by Kell Lanes on 24/06/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    func alertMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let email = textFieldEmail.text ?? ""
        let password = textFieldPassword.text ?? ""
        
        if email != "" && password != "" {
        APIService.enterLogin(email: email, password: password, completion: { responseData, error in
           
            if error != nil {
                print("error no acesso: \(String(describing: error))")
                self.alertMessage(title: "Dados incorretos", message: "Digite novamente")
                
            }
        })
        } else {
            self.alertMessage(title: "Dados incorretos", message: "email e Senha são requeridos!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
