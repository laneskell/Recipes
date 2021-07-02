//
//  APIService.swift
//  suduRecipes
//
//  Created by Jeann Luiz Chuab on 30/06/21.
//

import Foundation

struct Recipe: Codable {
    let id: String
    let image: String
    let title: String
    let description: String
    let created_at: String
    let category: String
    let author_id: String
}

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
            guard let responseData = data else {return}
            do {
                let jsonObject =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [ String: Any]
                if let dicionario = jsonObject {
                    if let token = dicionario["token"] as? String{
                        UserDefaults.standard.set(token, forKey: "token")
                    }
                }
                
            } catch {
                print("error: \(String(describing: error))")
              
            }
           
            
            completion(responseData, error)
        }
        task.resume()
    }
    
    class func createUsers(name:String, email:String, password:String, completion: @escaping (Data?, Error?) -> Void) {
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
            guard let responseData = data else {return}
        
            do {
                let jsonObject =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [ String: Any]
                if let dicionario = jsonObject {
                    if let token = dicionario["token"] as? String{
                        UserDefaults.standard.set(token, forKey: "token")
                        
                    }
                  
                }
                
            } catch {
            
            }
            completion(responseData, error)
        }
        task.resume()
    }
    
    class func getRecipeList( completion: @escaping (Data?, Error?, [Recipe]) -> Void) {
        let url = URL (string: "http://localhost:3003/recipe")!
                
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            if let validData = data {
                do {
                    let arrayRecipes =  try JSONDecoder().decode([Recipe].self, from: validData)
                    completion(validData, error, arrayRecipes)
                    
                } catch let error {
                    print("error: \(String(describing: error))")
                    completion(validData, error, [])
                }
                
            } else {
                completion(nil, error, [])
            }

        }
        task.resume()
    }
    
    class func createRecipe(title:String, url:String, category: String, description:String, completion: @escaping (Data?, Error?) -> Void) {
        let url_base = URL (string: "http://localhost:3003/recipe")!
        var request = URLRequest(url: url_base)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "title": title,
            "url": url,
            "category": category,
            "description": description
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in

            guard let responseData = data else {return}
            
            
            completion(responseData, error)
        }
        task.resume()
    }
}
