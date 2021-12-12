//
//  JoueurService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit.UIImage

class JoueurService{
    static let shareinstance = JoueurService()

    func addjoueur(joueur: joueurModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        print("hi")
        let headers: HTTPHeaders = [.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!))
]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            let ParametersS = [ "nom": joueur.nom!,
                                "prenom": joueur.prenom!,
                                "age": joueur.age!,
                                "taille": joueur.taille!,
                                "longueur": joueur.longueur!,
                                "num": joueur.num!,
                                "discription": joueur.discription!
            ] as [String : Any]
            for (key, value) in ParametersS {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Double {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                
                }
                
                print(multipartFormData)
            }
            },to: "http://localhost:3000/joueur",
        method: .post,headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
    }
    func makeItem(jsonItem: JSON) -> joueurModel {
    //let isoDate = jsonItem["dateNaissance"]
    joueurModel(
        _id: jsonItem["_id"].stringValue,
        nom: jsonItem["nom"].stringValue,
        prenom: jsonItem["prenom"].stringValue,
        age: jsonItem["age"].stringValue,
        taille: jsonItem["taille"].stringValue,
        longueur: jsonItem["longueur"].stringValue,
        num: jsonItem["num"].stringValue,
        discription: jsonItem["discription"].stringValue

    )
}
}
