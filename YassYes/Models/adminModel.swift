//
//  adminModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
struct  adminModel{
    internal init(image:String?=nil,
                  _id:String?=nil,
                  nom:String?=nil,
                  prenom:String?=nil,
                  email:String?=nil,
                  motdepasse:String?=nil,
                  isProprietaireDestade:String?=nil
    ){
        self.image = image
        self._id = _id
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.motdepasse = motdepasse
        self.isProprietaireDestade = isProprietaireDestade
    }
    let image : String?
    let _id : String?
    let nom : String?
    let prenom : String?
    let email : String?
    let motdepasse : String?
    let isProprietaireDestade : String?

    //var isVerified : Bool?

    //let token:String
   
}

