//
//  Models.swift
//  suduRecipes
//
//  Created by Kell Lanes on 24/06/21.
//

import Foundation
import SwiftUI

struct DataModel: Decodable {
    let error: String
    let message: String
    let data: [UserModel]
}

struct UserModel: Decodable {
    let name: String
    let email: String
    let password: String
}
