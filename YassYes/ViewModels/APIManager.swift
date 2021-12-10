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

/*extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}*/
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

class APIManger{
    static let shareInstence = APIManger()
    var ClientToken : adminModel?

    /*
    func register(photo:UIImage,admin : adminModel,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("multipart/form-data")]
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
    
    */
    /*
    func register(photo:UIImage,admin : adminModel?,completionHandler:@escaping (Bool)->())
    {
        let urlApi = "http://localhost:3000/user"
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data","Content-Disposition" : "form-data"]
        //var parameters = ["":""]
        //if
        let a = admin!
        //{
          var  parameters = ["nom":a.nom,"prenom":a.prenom,"email":a.email,"motdepasse":a.isProprietaireDestade]
        //}
        AF.upload(  multipartFormData: { multipartFormData in
                multipartFormData.append(photo.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "photo.jpeg", mimeType: "photo/jpeg")
                for (key, value) in parameters {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }
            },to: urlApi, method: .post ,headers: headers).response{ apiResponse in

                guard apiResponse.response != nil else{return}
                print(apiResponse)
                print(apiResponse.response)

                switch apiResponse.response?.statusCode {
                    case 200:
                    completionHandler(true)
                    case 500:
                    completionHandler(false)
                default:
                    print("error")
                }
}
}*/
    
    /*func DataBodyWithoutPass(user:User, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"nom\"\(lineBreak + lineBreak)")
        body.append("\(user.nom + lineBreak)")
        
        
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"prenom\"\(lineBreak + lineBreak)")
        body.append("\(user.prenom + lineBreak)")
        
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"email\"\(lineBreak + lineBreak)")
        body.append("\(user.email + lineBreak)")
        
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
   *
    func DataBody(admin:adminModel, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"nom\"\(lineBreak + lineBreak)")
        body.append("\(admin.nom + lineBreak)")
        
        
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"prenom\"\(lineBreak + lineBreak)")
        body.append("\(admin.prenom + lineBreak)")
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"isProprietaireDestade\"\(lineBreak + lineBreak)")
        body.append("\(admin.prenom + lineBreak)")
        
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"email\"\(lineBreak + lineBreak)")
        body.append("\(admin.email + lineBreak)")
        if !(admin.motdepasse ?? "").isEmpty{
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"motdepasse\"\(lineBreak + lineBreak)")
            body.append("\(admin.motdepasse + lineBreak)")
        }
        
        
       
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
    
    
    
    func CreationCompte(admin:adminModel, photo :UIImage, callback: @escaping (Bool)->()){
        
        guard let mediaImage = Media(withImage: photo, forKey: "photo") else { return }
        guard let url = URL(string: "http://localhost:3000/user") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //create boundary
        let boundary = generateBoundary()
        //set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //call createDataBody method
        
        let dataBody = DataBody(admin:admin, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response {
                }
                if let data = data {
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                            
                            if let reponse = json["reponse"] as? String{
                                    
                                    callback(true)
                                
                            }
                        }
                    } catch {
                        callback(false)
                    }
                }else{
                    callback(false)}}
        }.resume()
    }
    */
    /*
    func addUser(image:UIImage,user:adminModel?,successHandler: @escaping () -> (),errorHandler: @escaping () -> (),noResponseHandler: @escaping () -> ())
    {
            
        let urlApi = "http://localhost:3000/user"
        
      
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data"]
        
        
        var parameters = ["":""]
        
        if let a = user
        {
            
            parameters = ["nom":a.nom!,"prenom":a.prenom!,"email":a.email!,"isProprietaireDestade":a.isProprietaireDestade!,"motdepasse":a.motdepasse!]
            
        }
        
            
        AF.upload(
                
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "photo.jpeg", mimeType: "photo/jpeg")
               
                for (key, value) in parameters {

                    multipartFormData.append((value.data(using: .utf8))!, withName: key)

                }
            
            },to: urlApi, method: .post ,headers: headers).response{ apiResponse in
                    
                        
                guard apiResponse.response != nil else{
                    
                    noResponseHandler()
                    return
                }
                    
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                                            
                        successHandler()
        
                    case 500:
                        
                        errorHandler()
               
                default:
                
                    print("error")
                    errorHandler()
                    
                }
                    
        }
        
    }
*/
    var tokenString :String?
    @Published var isAuthenticated : Bool = false

    func loginGoogle(email:String,motdepasse:String,nom:String) {
        
        let defaults = UserDefaults.standard
        
        //Forced unwrapping with !
        var request = URLRequest(url: URL(string: "http://localhost:3000/user/auth")!)
        request.httpMethod = "post"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        print("its working")
        let postString = "email="+email+"&"+"motdepasse="+motdepasse+"&"+"nom="+nom+"&"
    
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error?.localizedDescription))")
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }

            let responseString = String(data: data, encoding: .utf8)
            let jsonData = responseString!.toJSON() as? [ String:AnyObject ]
            self.tokenString = jsonData!["token"] as? String
            print("token : ------------------")
            print(self.tokenString!)
            
            defaults.setValue(self.tokenString, forKey: "jsonwebtoken")

            
            self.getuserfromtoken(token: (jsonData!["token"] as? String)!)
            
            if(responseString!.contains("true")){
                print("status = true")
                
            }
            else{
                print("Status = false")
            }
        }
        task.resume()
    }
    func getuserfromtoken(token : String){
        var request = URLRequest(url: URL(string: "http://172.17.12.159:3000/Client/findToken")!)
                 request.httpMethod = "post"
                 request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                 print("its working")

                 request.addValue(token, forHTTPHeaderField: "authorization")
                 let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     guard let data = data, error == nil else {                                                 // check for fundamental networking error
                         print("error=\(String(describing: error?.localizedDescription))")
                         return
                     }

                     if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                         print("statusCode should be 200, but is \(httpStatus.statusCode)")
                         print("response = \(String(describing: response))")
                     }

                     let responseString = String(data: data, encoding: .utf8)
                     print("---------------------------------------------------")
                     print("responseString = \(String(describing: responseString))")
                     print("---------------------------------------------------")
                     let jsonData = responseString!.toJSON() as? [ String:AnyObject ]
                    
                   var newuser = adminModel()
                   
                         newuser._id = (jsonData!["_id"] as? String)!
                     newuser.nom = (jsonData!["userName"] as? String)!
                     newuser.prenom = (jsonData!["prenom"] as? String)!
                     newuser.email = (jsonData!["email"] as? String)!
                     newuser.motdepasse = (jsonData!["motdepasse"] as? String)
                     newuser.image = (jsonData!["image"] as? String)!
             
                         self.ClientToken = newuser
                     
                     
                     
                     if (responseString!.contains("_id")) {
                         print("status = true")
                   
                     }
                     else{
                         print("Status = false")
                         
                     }
                 }

                 task.resume()
                 
    }
    func adduser(admin: adminModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        print("hi")
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "nom": admin.nom!,
                        "prenom": admin.prenom!,
                        "email": admin.email!,
                        "isProprietaireDestade": admin.isProprietaireDestade!,
                        "motdepasse": admin.motdepasse!,
                        //"date": publication.date!,
                        //"utilisateur": UserDefaults.standard.string(forKey: "userId")!
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: "http://localhost:3000/user",
                  method: .post)
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

/*
class UserService  {

    

    

    static let shared: UserService = {

            let instance = UserService()

            return instance

        }()

   

    func addUser(image:UIImage,user:User?,successHandler: @escaping () -> (),errorHandler: @escaping () -> (),noResponseHandler: @escaping () -> ())

    {

            

        let urlApi = "http://localhost:3000/register"

        

      

        let headers: HTTPHeaders = ["Content-type": "multipart/form-data",

                   "Content-Disposition" : "form-data"]

        

        

        var parameters = ["":""]

        

        if let a = user

        {

            

            parameters = ["name":a.name!,"email":a.email!,"password":a.password!]

            

        }

        

            

        AF.upload(

                

            multipartFormData: { multipartFormData in

                

                multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")

               

                for (key, value) in parameters {



                    multipartFormData.append((value.data(using: .utf8))!, withName: key)



                }

            

            },to: urlApi, method: .post ,headers: headers).response{ apiResponse in

                    

                        

                guard apiResponse.response != nil else{

                    

                    noResponseHandler()

                    return

                }

                    

                switch apiResponse.response?.statusCode {

                    

                    case 200:

                                            

                        successHandler()

        

                    case 500:

                        

                        errorHandler()

               

                default:

                

                    print("error")

                    errorHandler()

                    

                }

                    

        }

        

    }

    

    

    

    



    func getUsers(successHandler: @escaping (_ anomalyList: [User]) -> (),errorHandler: @escaping () -> ())

    {

        

        let url = "http://localhost:3000/users"

        

        AF.request(url, method: .get).validate().responseDecodable(of: [User].self, decoder: JSONDecoder()) { apiResponse in

            

            guard apiResponse.response != nil else{

                

                errorHandler()

                return

            }

            

            switch apiResponse.response?.statusCode {

                

                case 200:

                successHandler(try! apiResponse.result.get())



                    

                case 500:

                 

                errorHandler()

           

            default:

            

              errorHandler()

                

            }

            

        }

        

    }

    

    

    func getUser(parameter:[String:String],successHandler: @escaping (_ user: User) -> (),wrongCred: @escaping () -> (),errorHandler: @escaping () -> ())

    {

        

        let url = "http://localhost:3000/login"

      

        AF.request(url, method: .post, parameters: ((parameter as NSDictionary) as! Parameters)).validate().responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in

            

            

            guard apiResponse.response != nil else{

                

                errorHandler()

                return

            }

            

            switch apiResponse.response?.statusCode {

                

                case 200:

                    

                    successHandler(try! apiResponse.result.get())

                    

                case 404:

                    

                    wrongCred()

                    

                case 500:

                    

                    errorHandler()

           

            default:

            

                errorHandler()

                

            }

            

        }

        

    }

    



    

    func updateUser(image:UIImage,user:User?,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())

    {

    

        let urlApi = "http://localhost:3000/updateUser/61abe4f312e1686a06cbd7cd"

        

        let headers: HTTPHeaders = ["Content-type": "multipart/form-data",

            "Content-Disposition" : "form-data"]



        

        var parameters = ["":""]

        

        if let a = user

        {

            

            parameters = ["_id":a._id!,"name":a.name!,"email":a.email!,"password":a.password!]

            

        }

     

        

    AF.upload(

            

        multipartFormData: { multipartFormData in

            

            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.jpeg", mimeType: "image/jpeg")

           

            for (key, value) in parameters {



                multipartFormData.append((value.data(using: .utf8))!, withName: key)



            }

        

        },to: urlApi, method: .post , headers: headers).responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in

            

            

            guard apiResponse.response != nil else{

                

                errorHandler()

                return

            }

            

            switch apiResponse.response?.statusCode {

                

                case 200:

                    

                    successHandler()

  

                case 500:

                    

                    errorHandler()

           

            default:

            

                errorHandler()

                

            }

        }

    

    }

    

    

    

    func sendEmail(email:String,successHandler: @escaping () -> (),wrongCred: @escaping () -> (),errorHandler: @escaping () -> ())

    {

        

        let url = "http://localhost:3000/sendEmail"

      

        AF.request(url, method: .post, parameters: ["email":email] ).validate().response { apiResponse in

            

                   

            guard apiResponse.response != nil else{

                

                errorHandler()

                return

            }

            

            switch apiResponse.response?.statusCode {

                

                case 200:

                    

                    successHandler()

                    

                case 404:

                    

                    wrongCred()

                    

                case 500:

                    

                    errorHandler()

           

            default:

            

                errorHandler()

                

            }

            

        }

        

    }

    



    

    

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



    

    

    

    

    

    

    

    

    

    

    

    

    

    









    

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    





















