//
//  recipeType.swift
//  suduRecipes
//
//  Created by Kell Lanes on 25/06/21.

import UIKit

class recipe {
    var id: String!
    var title: String!
    var image: String!
    var description: String!
    var created_at: String!
    var author_id: String!
    
    init(id: String,title: String, image: String, description: String, created_at:String, author_id: String){
        self.id = id
        self.title = title
        self.image = image
        self.description = description
        self.created_at = created_at
        self.author_id = author_id
    }
}
