//
//  viewModel.swift
//  suduRecipes
//
//  Created by Kell Lanes on 24/06/21.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var items = [DataModel]()
    let BASE_URL = "http://localhost:3003"
    
    init() {
//        fetchUsers()
    }
    
//    RETORNO DE DADOS. - GET
//    func fetchUsers() {
//        guard let url = URL(string: "\(BASE_URL)/users/profile") else {
//            print("Not found url")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, res, error) in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(DataModel.self, from:data)
//                    DispatchQueue.main.async {
//                        self.items = result.data
//                    }
//                }else{
//                    print("No data")
//                }
//
//            }catch let  JsonError {
//                print("fetch json error: ", JsonError.localizedDescription )
//            }
//
//        } .resume()
//     }
    
    
    //    CRIAR NOVO USUÁRIO - ENVIO DE DADOS. - POST
    func createUsers(parameters: [String: Any]) {
            guard let url = URL(string: "\(BASE_URL)/users/signup") else {
                print("Not found url")
                return
            }
            
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
            URLSession.shared.dataTask(with: request) { (data, res, error) in
                if error != nil {
                    print("error", error?.localizedDescription ?? "")
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode(DataModel.self, from:data)
                        DispatchQueue.main.async {
//                            let token = result.data.token
                            print(result)
                        }
                    }else{
                        print("No data")
                    }
                    
                }catch let  JsonError {
                    print("fetch json error: ", JsonError.localizedDescription )
                }
                
            } .resume()
         }
    
    
    
    
}
