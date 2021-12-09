//
//  arbitreModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
struct  arbitreModel{
    //let photo:String?
    internal init(image:String?=nil,
                  _id:String?=nil,
                  nom:String?=nil,
                  age:Int?=nil,
                  num:Int?=nil,
                  discription:String?=nil
    ){
        self.image = image
        self._id = _id
        self.nom = nom
        self.age = age
        self.num = num
        self.discription = discription
    }
    let image : String?
    let _id : String?
    let nom : String?
    let age : Int?
    let num : Int?
    let discription : String?
   
}

