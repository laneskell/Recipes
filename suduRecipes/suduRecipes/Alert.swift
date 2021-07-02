//
//  Alert.swift
//  suduRecipes
//
//  Created by Kell Lanes on 30/06/21.
//

import Foundation

class AlertCustom {
    
   class func alertCancel(title:String, message:String, completion: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    
    completion()
   }
    
  class  func alertConfirm(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}
