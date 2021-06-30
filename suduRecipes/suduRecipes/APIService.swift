//
//  APIService.swift
//  suduRecipes
//
//  Created by Jeann Luiz Chuab on 30/06/21.
//

import Foundation

class APIService {
    
   class func enterLogin(email:String, password:String, completion: @escaping (Data?, Error?) -> Void) {
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
        
            //Criei uma closure, dessa forma você pode manipular a resposta direto no local onde você tá chamando
            completion(responseData, error)
        }
        task.resume()
    }
}
