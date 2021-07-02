//
//  signupViewController.swift
//  suduRecipes
//
//  Created by Kell Lanes on 24/06/21.
//

import UIKit


class signupViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFielEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordConfirm: UITextField!
    
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
    
    @IBAction func buttonCreateUser(_ sender: Any) {
    
        let name = textFieldName.text ?? ""
        let email = textFielEmail.text ?? ""
        let password = textFieldPassword.text ?? ""
        let passwordConfirm = textFieldPasswordConfirm.text ?? ""
        
                        if password == passwordConfirm {
                            
                            if name != "" &&  email != "" && password != "" {
                                
                                APIService.createUsers(name: name, email: email, password: password, completion:{ responseData, error in
                                    if error == nil {
                                        self.alertConfirm(title: "Sucesso", message: "Usuário cadastrado!")
                                        
                                    }else{
                                        self.alertMessage(title: "Dados incorretos", message: "Digite novamente")
                                    }
                                })
                               
                            }else {
                                self.alertMessage(title: "Dados incorretos", message: "Não pode deixar vazio, preencha todos os campos!")
                            }
                            
                        }else {
                            self.alertMessage(title: "Dados incorretos", message: "As senhas precisam ser iguais")
                } 
            }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }


}
