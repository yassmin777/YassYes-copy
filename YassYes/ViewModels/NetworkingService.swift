//
//  NetworkingService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 29/11/2021.
//

//


import Foundation
import Alamofire
import SwiftyJSON


/*enum MyResult<T, E: Error> {
 
 case success(T)
 case failure(E)
 
 }*/
class NetworkingService{
    
    //let baseUrl = "http://localhost:3000/sifflet/api/auth/signin"
    
    func request(email: String, motdepasse: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request("http://localhost:3000/sifflet/api/auth/signin",
                   method: .post,
                   parameters: ["email": email, "motdepasse": motdepasse])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    /*let jsonData = JSON(response.data!)
                    let utilisateur = self.makeItem(jsonItem: jsonData)
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "accessToken")
                    print(utilisateur)
                    print(UserDefaults.standard)
                    //print(jsonData)
                    
                    completed(true, utilisateur)*/
                    if let jsonRes  = try? JSONSerialization.jsonObject(with: response.data!, options:[] ) as? [String: Any]{
                       print("JSON", jsonRes)
                        if jsonRes["accessToken"] != nil {
                           
                            
                            UserDefaults.standard.setValue(jsonRes["accessToken"], forKey: "token")

                            UserDefaults.standard.setValue(jsonRes["id"], forKey: "id")
                        /*}
                        if let reponse = jsonRes["user"] as? [String: Any]{
                            for (key,value) in reponse{
                               // print("++++++++++",key,value)
                                UserDefaults.standard.setValue(value, forKey: key)
                                
                            }
                            UserDefaults.standard.setValue("", forKey: "password")*/
                            print(UserDefaults.standard.string(forKey: "token"))
                            completed(true,"good")
                            
                        }else{
                            completed(false,"pas inscrit")
                        }
                    }else{
                        completed(false,nil)
                    }
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
/*
    func makeItem(jsonItem: JSON) -> adminModel {
        //let isoDate = jsonItem["dateNaissance"]
        
        return adminModel(
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            email: jsonItem["email"].stringValue,
            role: jsonItem["role"].stringValue,
            motdepasse: jsonItem["motdepasse"].stringValue
            //token: jsonItem["token"].stringValue

            
        )
    }
    */
}

