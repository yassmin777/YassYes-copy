//
//  EquipeService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit.UIImage
class EquipeService{
    static let shareinstance = EquipeService()

    func addequipe(equipe: equipeModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        print("hi")
        let headers: HTTPHeaders = [.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!))
]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            let ParametersS = [ "nom": equipe.nom!,
                                "discription": equipe.discription!
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
            },to: Host+"/equipe", method: .post,headers: headers)
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
    func sccore(id: String, score: Int,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request(Host+"/match/"+id, method: .put, parameters:[ "score":score] ,encoder: JSONParameterEncoder.default, headers: headers ).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 201{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false)
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func donnerDesPoint(idA: String, idB: String,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request(Host+"/match/up", method: .put, parameters:[ "idA":idA,"idB":idB] ,encoder: JSONParameterEncoder.default, headers: headers ).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 201{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false)
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    
    
    func addJoueurToEquipe(_id:String, joueurs_id: String,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/x-www-form-urlencoded"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request(Host+"/equipe/"+_id, method: .put,parameters:[ " joueurs_id":joueurs_id] , headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        let jsonData = JSON(response.data!)
                        let user = self.makeItem(jsonItem: jsonData)
                        completionHandler(true)

                        print(user)
                    }else{
                        completionHandler(false)
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false)
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func makeItem(jsonItem: JSON) -> adminModel {
    //let isoDate = jsonItem["dateNaissance"]
    adminModel(
        _id: jsonItem["_id"].stringValue,
        nom: jsonItem["nom"].stringValue,
        prenom: jsonItem["prenom"].stringValue,
        email: jsonItem["email"].stringValue,
        motdepasse: jsonItem["motdepasse"].stringValue,
        isProprietaireDestade: jsonItem["isProprietaireDestade"].stringValue

    )
}
}
