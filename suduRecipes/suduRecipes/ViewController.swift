//
//  ViewController.swift
//  suduRecipes
//
//  Created by Kell Lanes on 24/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//      getRecipeList()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
     func getProfile() {
        let url = URL (string: "http://localhost:3003/users/profile")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        


        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            print("response: \(String(describing: response))")
            print("error: \(String(describing: response))")

            guard let responseData = data else {return}
            

            if let responseString = String(data: responseData,
                encoding: .utf8){
                print(responseString)
            }

        }
        task.resume()
    }
    
//    func createUsers(name:String, email:String, password:String) {
//        let url = URL (string: "http://localhost:3003/users/signup")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let json = [
//            "name": name,
//            "email": email,
//            "password": password
//        ]
//        
//        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
//       
//        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
//            print("response: \(String(describing: response))")
//            print("error: \(String(describing: error))")
//
//            guard let responseData = data else {return}
//        
//            do {
//                let jsonObject =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [ String: Any]
//                if let dicionario = jsonObject {
//                    if let token = dicionario["token"] as? String{
//                        UserDefaults.standard.set(token, forKey: "token")
//                    }
//                    if let idade = dicionario["idade"] as? Int{
//                        print(idade)
//                    }
//                }
//                
//            }catch{
//            
//            }
//            if let responseString = String(data: responseData,
//                encoding: .utf8){
//                print(responseString)
//            }
//        }
//
//        
//        task.resume()
//    }

//
//    func getRecipeList() {
//        let url = URL (string: "http://localhost:3003/recipe")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////        let token:String = UserDefaults.standard.string(forKey: "token")!
////        print(token)
////        request.setValue(token, forHTTPHeaderField: "Authorization")
//
//
//        let task = URLSession.shared.dataTask(with: url) {
//            (data, response, error) in
//
//            print("response: \(String(describing: response))")
//            print("error: \(String(describing: error))")
//
//            guard let responseData = data else {return}
//
//            do {
//                let jsonObject =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [ String: Any]
//
////                if let dicionario = jsonObject {
////                    print(dicionario)
////                }
//
//            }catch{
//                print(error)
//            }
//            if let responseString = String(data: responseData,
//                encoding: .utf8){
//                print(responseString)
//            }
//        }
//
//
//        task.resume()
//    }

}

