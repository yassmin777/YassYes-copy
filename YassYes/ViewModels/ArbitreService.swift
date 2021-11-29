//
//  ArbitreService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
class ArbitreService{
    static let shareinstance = ArbitreService()

    func AddJ(arbitre : arbitreModel)-> Int{
        var status: Int = 0
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "nom="+arbitre.nom+"&prenom="+arbitre.prenom+"&age="+arbitre.age+"&num="+arbitre.num+"&discription="+arbitre.discription
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://localhost:3000/sifflet/arbitre")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return status

    }
}
