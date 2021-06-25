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
        
        enterLogin(email: email, password: password)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func enterLogin(email:String, password:String) {
        let url = URL (string: "http://localhost:3003/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "email": email,
            "password": password
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
       
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")

            guard let responseData = data else {return}
        
            if error == nil{
                print(responseData)

            }else{
                self.alertMessage(title: "Dados incorretos", message: "Digite novamente")
            }
            
        }

        
        task.resume()
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
