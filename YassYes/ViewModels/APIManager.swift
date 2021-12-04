//
//  APIManager.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 03/12/2021.
//


import Foundation
import Alamofire
import SwiftyJSON
class APIManger{
    static let shareInstence = APIManger()
    
    func register(admin : adminModel,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/json")]
        AF.request("http://localhost:3000/user", method: .post, parameters: admin,encoder: JSONParameterEncoder.default, headers: headers ).response{ response in debugPrint(response)
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
    func login(email: String, motdepasse: String,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/json")]
        AF.request("http://localhost:3000/user/login", method: .post, parameters: ["email":email, "motdepasse": motdepasse],encoder: JSONParameterEncoder.default, headers: headers ).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    //print(json)
                    if response.response?.statusCode == 200{
                
                        let jsonData = JSON(response.data!)
                        print(jsonData)
                        //UserDefaults.standard.set(jsonData["token"].stringValue, forKey: "token")
                        UserDefaults.standard.setValue(jsonData["token"].stringValue  , forKey: "token")

                        //let jsonData = JSON(response.data!)
                        UserDefaults.standard.set(jsonData["_id"].stringValue, forKey: "_id")
                        //UserDefaults.standard.set(jsonData["prenom"].stringValue, forKey: "prenom")
                        //UserDefaults.standard.set(jsonData["email"].stringValue, forKey: "email")

                        print(UserDefaults.standard.string(forKey: "token")!)
                        print(UserDefaults.standard.string(forKey: "_id")!)

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
    
    func getProfile(_id:String,completionHandler:@escaping (Bool,adminModel?)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/user/profile", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        let jsonData = JSON(response.data!)
                        let user = self.makeItem(jsonItem: jsonData)
                        completionHandler(true,user)

                        print(user)
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
    
    func updateProfile(_id:String,nom:String,prenom:String,email:String,motdepasse:String,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/x-www-form-urlencoded"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "Token")!)) ]
        AF.request("http://localhost:3000/user/profile", method:   .put ,parameters:[ "_id":_id,"nom":nom,"prenom":prenom,"email":email,"motdepasse":motdepasse], headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 201{
                        //let jsonData = JSON(response.data!)
                        //let user = self.makeItem(jsonItem: jsonData)
                        completionHandler(true)

                        //print(user)
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
