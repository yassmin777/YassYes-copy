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

    func addjoueurHH(joueur: joueurModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
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
    func getJoueurProfile(_id:String,completionHandler:@escaping (Bool,joueurModel?)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/joueur/"+_id, method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        let jsonData = JSON(response.data!)
                        print("ttttttt")
                        print(jsonData)
                        print("ttttttt")
                        let joueur = self.makeItem(jsonItem: jsonData["joueur"])
                        completionHandler(true,joueur)

                        print(joueur)
                    }else{
                        completionHandler(false,nil)
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false,nil)
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func makeItem(jsonItem: JSON) -> joueurModel {
    //let isoDate = jsonItem["dateNaissance"]
    joueurModel(
        image: jsonItem["image"].stringValue,
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
