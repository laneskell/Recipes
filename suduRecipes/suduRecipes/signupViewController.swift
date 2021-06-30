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
        
        
                        /*Validar senhas iguais*/
                        if password == passwordConfirm {
                            
                            if name != "" &&  email != "" && password != "" {
                                
                                createUsers(name: name,email: email,password: password)
                               
                            }else {
                                self.alertMessage(title: "Dados incorretos", message: "Não pode deixar vazio, preencha todos os campos!")
                            }
                            
                        }else {
                            self.alertMessage(title: "Dados incorretos", message: "As senhas precisam ser iguais")
                } /*fim valid senha*/
            }
        
    
    func createUsers(name:String, email:String, password:String) {
        let url = URL (string: "http://localhost:3003/users/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
       
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")

            guard let responseData = data else {return}
        
            do {
                let jsonObject =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [ String: Any]
                if let dicionario = jsonObject {
                    if let token = dicionario["token"] as? String{
                        UserDefaults.standard.set(token, forKey: "token")
                        self.alertConfirm(title: "Sucesso!", message: "Usuário cadastrado, Bem vind@!")
                    }
                  
                }
                
            }catch{
            
            }
            if let responseString = String(data: responseData,
                encoding: .utf8){
                print(responseString)
            }
        }

        
        task.resume()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
