//
//  APIManager.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 03/12/2021.
//
    
    
    

        



import Foundation
import Alamofire
import SwiftyJSON
import UIKit.UIImage



class APIManger{
    static let shareInstence = APIManger()
    var ClientToken : adminModel?

   
    var tokenString :String?
    @Published var isAuthenticated : Bool = false

   
    func loginGoogle(nom:String,prenom:String,email: String, motdepasse: String,completionHandler:@escaping (Bool)->()){
    let headers: HTTPHeaders = [.contentType("application/json")]
        AF.request("http://localhost:3000/user/google", method: .post, parameters: ["nom":nom,"prenom":prenom,"email":email, "motdepasse": motdepasse],encoder: JSONParameterEncoder.default, headers: headers ).response{ response in debugPrint(response)
        switch response.result{
        case .success(let data):
            do {
                let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                if response.response?.statusCode == 200{
            
                    let jsonData = JSON(response.data!)
                    print(jsonData)
                    UserDefaults.standard.setValue(jsonData["token"].stringValue  , forKey: "token")
                    UserDefaults.standard.setValue(jsonData["isProprietaireDeStade"].stringValue, forKey: "isProprietaireDestade")
                    UserDefaults.standard.set(jsonData["_id"].stringValue, forKey: "_id")
                    
                    print(UserDefaults.standard.string(forKey: "token")!)
                    print(UserDefaults.standard.string(forKey: "isProprietaireDestade"))
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
    
    func adduser(admin: adminModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        print("hi")
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            let ParametersS =
                    [
                        "nom": admin.nom!,
                        "prenom": admin.prenom!,
                        "email": admin.email!,
                        "isProprietaireDestade": admin.isProprietaireDestade!,
                        "motdepasse": admin.motdepasse!,
                        //"date": publication.date!,
                        //"utilisateur": UserDefaults.standard.string(forKey: "userId")!
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
            }
        },to: "http://localhost:3000/user",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                    switch response.result{
                    case .success(let data):
                        do {
                            let json  = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)
                            if response.response?.statusCode == 201{
                                let jsonData = JSON(response.data!)
                                UserDefaults.standard.setValue(jsonData["_id"].stringValue, forKey: "_id")
                                
                                print(jsonData["_id"].stringValue)
                                completed(true)

                            }else{
                                completed(false)
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                            completed(false)
                            
                            
                        }
                case let .failure(error):
                    completed(false)
                    print(error)
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
                        UserDefaults.standard.setValue(jsonData["token"].stringValue  , forKey: "token")
                        UserDefaults.standard.setValue(jsonData["isProprietaireDestade"].stringValue, forKey: "isProprietaireDestade")
                        UserDefaults.standard.set(jsonData["_id"].stringValue, forKey: "_id")
                        
                        print(UserDefaults.standard.string(forKey: "token")!)
                        print(UserDefaults.standard.string(forKey: "isProprietaireDestade"))
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
                        print("ttttttt")
                        print(jsonData)
                        print("ttttttt")
                        let user = self.makeItem(jsonItem: jsonData["user"])
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
        let headers: HTTPHeaders = [.contentType("application/x-www-form-urlencoded"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
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
            image: "http://localhost:3000/"+jsonItem["image"].stringValue,
            _id: jsonItem["_id"].stringValue,
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            email: jsonItem["email"].stringValue,
            motdepasse: jsonItem["motdepasse"].stringValue,
            isProprietaireDestade: jsonItem["isProprietaireDestade"].stringValue

        )
    }
    
    func verifyCode(_id:String,code: String,completionHandler:@escaping (Bool)->()){
         let headers: HTTPHeaders = [.contentType("application/x-www-form-urlencoded") ,.authorization(bearerToken:(UserDefaults.standard.string(forKey: "_id")!))]
        AF.request("http://localhost:3000/user/verifEmail/"+_id,  method:   .patch ,parameters: ["verifCode":code] ,  headers: headers ).response{ response in
             switch response.result{
             case .success(let data):
                 do {
                     let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                     print(json)
                     if response.response?.statusCode == 201{
                         //let jsonData = JSON(response.data!)
                         print(code)
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
                 print("eeee")
                 print(err.localizedDescription)
             }
         }
     }
}



    

    /*

    func updatePassword(email:String,password:String,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())

    {

        

        let url = "http://localhost:3000/updatePassword"

      

        AF.request(url, method: .put, parameters: ["email":email,"password":password] ).validate().response { apiResponse in

            

                   

            guard apiResponse.response != nil else{

                

                errorHandler()

                return

            }

            

            switch apiResponse.response?.statusCode {

                

                case 200:

                    

                    successHandler()

                    

                case 404:

                    

                    errorHandler()

                    

                case 500:

                    

                    errorHandler()

           

            default:

            

                errorHandler()

                

            }

            

        }

        

    }

  */



    

    

    

    

    

    

    

    

    

    

    

    

    

    









    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    





















